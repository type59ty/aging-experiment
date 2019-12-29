DIR_SRC = ./source_code
DIR_OBJ = ./object_code

SRC = $(wildcard ${DIR_SRC}/*.cpp)  
OBJ = $(patsubst %.cpp,${DIR_OBJ}/%.o,$(notdir ${SRC})) 

CC = g++
CFLAGS = -Wall -O3

main:${OBJ}
	$(CC) $(OBJ) -o main    
${DIR_OBJ}/%.o:${DIR_SRC}/%.cpp
	$(CC) $(CFLAGS) -c $< -o $@
.PHONY:clean
clean:
	find ${DIR_OBJ} -name *.o -exec rm -rf {} \;
