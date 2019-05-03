DIR_INC = ./inc
DIR_SRC = ./src
DIR_BUILD = ./build
DIR_BIN = ./bin

STCFLASH = ./tool/stcflash.py

CC = sdcc
PROJ_NAME = led
CFLAGS = -I${DIR_INC}

# 获取源文件列表
SRCS = $(wildcard ${DIR_SRC}/*.c)  

# 获取目标文件列表,附加了目录
RELS = $(patsubst %.c,${DIR_BUILD}/%.rel,$(notdir ${SRCS})) 

# 最终目标由.hex生成.bin文件
$(DIR_BIN)/$(PROJ_NAME).bin : $(DIR_BIN)/$(PROJ_NAME).hex
	objcopy -I ihex -O binary $< $@

# 生成.hex文件
$(DIR_BIN)/$(PROJ_NAME).hex : $(DIR_BIN)/$(PROJ_NAME).ihx
	packihx $< > $@

# 由.rel文件产生.ihx文件, 放到bin目录中
$(DIR_BIN)/$(PROJ_NAME).ihx : $(RELS) | $(DIR_BIN)
	$(CC) $^ -o $@

# 编译.c文件生产.rel文件 把.rel和所有中间文件放到build目录中
${DIR_BUILD}/%.rel : ${DIR_SRC}/%.c | $(DIR_BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

# 如果文件夹还没有创建，则建立文件夹
$(DIR_BUILD) :
	mkdir $(DIR_BUILD)

$(DIR_BIN) :
	mkdir $(DIR_BIN)

# ---------辅助构建---------------
.PHONY : flash clean print

# 下载代码
flash:
	python ${STCFLASH} $(DIR_BIN)/$(PROJ_NAME).bin

# 清除文件
clean :
	rm -f $(DIR_BUILD)/*

print:
	echo "debug"


