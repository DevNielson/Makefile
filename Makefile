CXX := g++
VERSION := -std=c++23
WARNINGS := -Wall -Wextra -g
#SANITIZE := -fsanitize=address
OPTIMIZATION := -O2
CXX_FLAGS := $(VERSION) $(WARNINGS) $(OPTIMIZATION)
CXX_LINKERS := -lstdc++exp

BIN_DIR := ../bin
BUILD_DIR := ../build
INCLUDE_DIR := -I ../include
SRC_DIR := ../src
SOURCE := $(wildcard $(SRC_DIR)/*.cpp)
OBJECTS := $(patsubst $(SRC_DIR)/%.cpp,$(BUILD_DIR)/%.o,$(SOURCE))
TARGET := $(BIN_DIR)/output.exe

SDL_INCLUDE := -I C:/SDL3/x86_64-w64-mingw32/include
SDL_IMAGE_INCLUDE := -I C:/SDL3_image/x86_64-w64-mingw32/include
SDL_TTF_INCLUDE := -I C:/SDL3_ttf/x86_64-w64-mingw32/include

SDL_LIB := -L C:/SDL3/x86_64-w64-mingw32/lib
SDL_IMAGE_LIB := -L C:/SDL3_image/x86_64-w64-mingw32/lib
SDL_TTF_LIB := -L C:/SDL3_ttf/x86_64-w64-mingw32/lib

SDL_LINKERS := -lSDL3 -lSDL3_image -lSDL3_ttf

INCLUDES :=  $(INCLUDE_DIR) $(SDL_INCLUDE) $(SDL_IMAGE_INCLUDE) $(SDL_TTF_INCLUDE)
LIBS := $(SDL_LIB) $(SDL_IMAGE_LIB) $(SDL_TTF_LIB)
LINKERS := $(CXX_LINKERS) $(SDL_LINKERS)

.PHONY: all
all: $(TARGET)

.PHONY: run
run: $(TARGET)
	@$^

$(TARGET): $(OBJECTS)
	@$(CXX) $(CXX_FLAGS) -o $@ $^ $(INCLUDES) $(LIBS) $(LINKERS)

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@$(CXX) $(CXX_FLAGS) -c -o $@ $< $(INCLUDES) $(LIBS)

.PHONY: clean
clean:
	@rm $(BUILD_DIR)/*.o $(TARGET)
