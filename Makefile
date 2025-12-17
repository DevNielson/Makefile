CXX := g++
VERSION := -std=c++23
WARNINGS := -Wall -Wextra -g
#SANITIZE := -fsanitize=address
OPTIMIZATION := -O2
CXX_FLAGS := $(VERSION) $(WARNINGS) $(OPTIMIZATION)
CXX_LINKERS := -lstdc++exp

INCLUDE := -I ../include

SDL := -I C:/SDL3/x86_64-w64-mingw32/include -L C:/SDL3/x86_64-w64-mingw32/lib
SDL_IMAGE := -I C:/SDL3_image/x86_64-w64-mingw32/include -L C:/SDL3_image/x86_64-w64-mingw32/lib
SDL_TTF := -I C:/SDL3_ttf/x86_64-w64-mingw32/include -L C:/SDL3_ttf/x86_64-w64-mingw32/lib
SDL_FLAGS := $(SDL) $(SDL_IMAGE) $(SDL_TTF)
SDL_LINKERS := -lSDL3 -lSDL3_image -lSDL3_ttf

LINKERS := $(CXX_LINKERS) $(SDL_LINKERS)

BIN_DIR := ../bin
BUILD_DIR := ../build
SRC_DIR := ../src
SOURCE := $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SOURCE))
TARGET := $(BIN_DIR)/output.exe

.PHONY: all
all: $(TARGET)

.PHONY: run
run: $(TARGET)
        @$^

$(TARGET): $(OBJECTS)
        @$(CXX) $(CXX_FLAGS) -o $@ $^ $(INCLUDE) $(SDL_FLAGS) $(LINKERS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
        @$(CXX) $(CXX_FLAGS) -c -o $@ $< $(INCLUDE) $(SDL_FLAGS)

.PHONY: clean
clean:
        @rm $(BUILD_DIR)/*.o $(TARGET)
