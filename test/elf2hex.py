import binascii
import codecs
import sys

default_file_name='./workbench/hello world/src/res2.o'

class Section():
	"""docstring for Section"""
	def __init__(self):
		super(Section, self).__init__()
		self.name = None
		self.type = None
		self.flag = None
		self.virtual_addr = None
		self.offset = None
		self.size = None
		self.link = None
		self.info = None
		self.addr_align = None
		self.data = ''
		pass

	def show(self):
		print(self.name)
		print('|addr: '+str(self.virtual_addr))
		print('|offset: '+str(self.offset))
		print('|size: '+str(self.size))
		print('|align: '+str(self.addr_align))
		print('********************************************')
		pass

class Program(object):
	"""docstring for Program"""
	def __init__(self):
		super(Program, self).__init__()
		self.type = None
		self.offset = None
		self.virtual_addr = None
		self.Physical_addr = None
		self.file_size = None
		self.memory_size = None
		self.addr_align = None
		self.data_list = None

	def show(self):
		print('Program Section')
		print('|type         : '+self.type)
		print('|virtual  addr: '+str(self.virtual_addr))
		print('|Physical addr: '+str(self.Physical_addr))
		print('|offset       : '+str(self.offset))
		print('|size         : '+str(self.file_size))
		print('********************************************')
		#print(self.data_list)
		pass

		

def getData(list_t,offset,size,little_endianness=True,base_addr=0):
	string=''
	offset=int(offset,base=16)+base_addr
	#print(offset)
	if little_endianness:
		for x in range(0,size):
			#print(list_t[offset+x])
			string+=list_t[offset+size-x-1]
			pass
		pass
	else:
		for x in range(0,size):
			string+=list_t[offset+x]
			pass
		pass
	
	return [int(string,base=16),string]
	pass

def getShstrtab(list_t,shstrtab_offset,shstrtab_size):
	string_list=[]
	string=''
	for x in range(0,shstrtab_size):
		data=list_t[shstrtab_offset+x]
		if (int(data,base=16)==0)|(x==shstrtab_size-1):
			print(string)
			string=codecs.decode(string, "hex").decode("utf-8")
			string_list.append(string)
			string=''
			pass
		else:
			string+=data
			pass
		pass
	print(string_list)
	return string_list
	pass

def getSectionName(list_t,shstrtab_offset,shstrtab_size,start_offset):
	string_list=[]
	string=''
	for x in range(start_offset,shstrtab_size):
		data=list_t[shstrtab_offset+x]
		if (int(data,base=16)==0)|(x==shstrtab_size-1):
			print(string)
			string=codecs.decode(string, "hex").decode("utf-8")
			string_list.append(string)
			string=''
			break
			pass
		else:
			string+=data
			pass
		pass
	return string_list[0]
	pass

def getSection(list_t,section_header_offset,shstrtab_offset,shstrtab_size):
	res=Section()
	shstrtab_start_offset = getData(list_t,'0x00',4,base_addr=section_header_offset)[0]
	res.name=getSectionName(list_t,shstrtab_offset,shstrtab_size,shstrtab_start_offset)
	res.virtual_addr=getData(list_t,'0x0c',4,base_addr=section_header_offset)
	res.offset=getData(list_t,'0x10',4,base_addr=section_header_offset)
	res.size=getData(list_t,'0x14',4,base_addr=section_header_offset)
	res.addr_align=getData(list_t,'0x20',4,base_addr=section_header_offset)
	res.show()
	return res
	pass

def getProgram(list_t,program_header_offset):
	program_type_list= {0:'PT_NULL',1:'PT_LOAD',2:'PT_DYNAMIC',3:'PT_INTERP',4:'PT_NOTE',5:'PT_SHLIB',6:'PT_PHDR',7:'PT_TLS'}
	res=Program()
	res.type=program_type_list[getData(list_t,'0x00',4,base_addr=program_header_offset)[0]]
	res.offset=getData(list_t,'0x04',4,base_addr=program_header_offset)
	res.virtual_addr=getData(list_t,'0x08',4,base_addr=program_header_offset)
	res.Physical_addr=getData(list_t,'0x0c',4,base_addr=program_header_offset)
	res.file_size=getData(list_t,'0x10',4,base_addr=program_header_offset)
	res.memory_size=getData(list_t,'0x14',4,base_addr=program_header_offset)
	res.data_list=list_t[res.offset[0]:res.offset[0]+res.file_size[0]]
	res.show()
	return res
	pass

def toHexFileLine(hex_string,addr):
	string=':01'
	for x in range(0,4-len(hex(addr)[2:])):
		string+='0'
		pass
	string+=hex(addr)[2:]+'00'+hex_string
	add_all=1+int(string[3:5],base=16)+int(string[5:7],base=16)+int(hex_string,base=16)
	add_all=(hex(256-int((hex(add_all)[2:])[-2:],base=16))[2:])[-2:]
	if len(add_all)==1:
		string+='0'
		pass
	string+=add_all+'\n'
	#print(string)
	return string
	pass

def writeHexFile(program_list,file_name='ram.hex',memory_max_size=256):
	max_file_len=0
	for x in range(0,len(program_list)):
		p=program_list[x]
		if (p.Physical_addr[0]+p.memory_size[0])>max_file_len:
			max_file_len=p.Physical_addr[0]+p.memory_size[0]
			pass
		pass
	#print('max file length: '+str(max_file_len/4))
	if max_file_len/4 > memory_max_size:
		print('ERROR:out of memory')
		return
		pass
	image_list=[]
	for x in range(0,memory_max_size):
		image_list.append('00')
		pass
	for x in range(0,len(program_list)):
		p=program_list[x]
		for i in range(0,p.memory_size[0]):
			image_list[p.Physical_addr[0]+i]=p.data_list[i]
			pass
		pass
	#print(image_list)
	hex_file=open(file_name,'w')
	for x in range(0,len(image_list)):
		hex_file.write(toHexFileLine(image_list[x],x))
		pass
	hex_file.write(':00000001ff')
	hex_file.close()
	print('ram.hex file generated')
	print('done')



	pass


def elf2hex(file):
	f=open(file,'rb')
	hexdata = binascii.hexlify(f.read())
	hexdata=hexdata.decode("utf-8")
	#print(hexdata)

	hex_list=[]
	for i in range(0,int(len(hexdata)/2)):
		hex_list.append(hexdata[2*i]+hexdata[2*i+1])
		pass
	#print(hex_list)

	EI_MAG0=hex_list[0]
	EI_MAG3=codecs.decode((hex_list[1]+hex_list[2]+hex_list[3]), "hex").decode("utf-8")
	
	if (EI_MAG0 != '7f')|(EI_MAG3 != 'ELF'):
		print('not a ELF file')
		return
		pass
	EI_CLASS=int(hex_list[4],base=16)*32
	EI_DATA='little endianness'
	if int(hex_list[5],base=16)!=1:
		EI_DATA='big endianness'
		pass
	#print(EI_CLASS)

	e_entry=getData(hex_list,'0x18',4)

	e_phoff=getData(hex_list,'0x1c',4)
	e_phentsize=getData(hex_list,'0x2a',2)
	e_phnum=getData(hex_list,'0x2c',2)

	e_shoff=getData(hex_list,'0x20',4)
	e_shentsize=getData(hex_list,'0x2e',2)
	e_shnum=getData(hex_list,'0x30',2)


	shstrtab_offset=getData(hex_list,'0x10',4,base_addr=e_shoff[0]+(e_shnum[0]-1)*e_shentsize[0])[0]
	shstrtab_size=getData(hex_list,'0x14',4,base_addr=e_shoff[0]+(e_shnum[0]-1)*e_shentsize[0])[0]

	program_list=[]
	for x in range(0,e_phnum[0]):
		program_list.append(getProgram(hex_list,e_phoff[0]+x*e_phentsize[0]))
		pass

	writeHexFile(program_list)


	pass

def main():
	if len(sys.argv)<2:
		elf2hex(default_file_name)
	else:
		elf2hex(sys.argv[1])
		pass
	pass

if __name__ == '__main__':
	main()