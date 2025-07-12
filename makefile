CXX = g++
CC  = gcc

TARGET = englang
SRC_DIR = src
LUA_DIR = src-lua
BUILD_DIR = build

CPP_SRC = $(SRC_DIR)/main.cpp
LUA_SRC = $(filter-out $(LUA_DIR)/luac.c,$(wildcard $(LUA_DIR)/*.c))

CPP_OBJ = $(BUILD_DIR)/main.o
LUA_OBJ = $(patsubst $(LUA_DIR)/%.c,$(BUILD_DIR)/%.o,$(LUA_SRC))

CXXFLAGS = -std=c++17 -O2 -Wall
CFLAGS   = -O2 -Wall -DLUA_COMPAT_5_3

LDFLAGS  = 

ifeq ($(OS),Windows_NT)
    EXE_EXT = .exe
    MKDIR = if not exist $(BUILD_DIR) mkdir $(BUILD_DIR)
    RM = del /Q /F
    RMDIR = rmdir /S /Q
else
    EXE_EXT =
    MKDIR = mkdir -p $(BUILD_DIR)
    RM = rm -f
    RMDIR = rm -rf
endif

BIN = $(TARGET)$(EXE_EXT)

all: $(BIN)

# Link final binary
$(BIN): $(CPP_OBJ) $(LUA_OBJ)
	@$(MKDIR)
	$(CXX) $^ -o $@ $(LDFLAGS)
	@echo "Built $(BIN)"

# C++ build rule
$(BUILD_DIR)/main.o: $(CPP_SRC)
	@$(MKDIR)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Lua C source build rule
$(BUILD_DIR)/%.o: $(LUA_DIR)/%.c
	@$(MKDIR)
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	-@$(RM) $(BIN)
	-@$(RMDIR) $(BUILD_DIR)

.PHONY: all clean
