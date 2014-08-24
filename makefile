#######################
# Include local 
-include uservars.mk
#######################

ifndef TEXADA_HOME
  $(error TEXADA_HOME shell variable is not set)
endif
ifndef SPOT_LIB
  $(error SPOT_LIB variable is not set (see uservars.mk.example))
endif
ifndef GTEST_LIB
  $(error GTEST_LIB variable is not set (see uservars.mk.example))
endif
ifndef SPOT_INCL
  $(error SPOT_INCL variable is not set (see uservars.mk.example))
endif
ifndef GTEST_INCL
  $(error GTEST_INCL variable is not set (see uservars.mk.example))
endif
ifndef BOOST_INCL
  $(error BOOST_INCL variable is not set (see uservars.mk.example))
endif

RM := rm -rf

LIBS := -lspot -lgtest -lpthread -lgtest_main -lboost_program_options -lboost_regex

TX_SRC := texada-src/
SRC := $(TX_SRC)src/
BIN_ROOT := $(TX_SRC)bin/
BIN := $(BIN_ROOT)src/
TESTS_SRC := $(TX_SRC)tests/
TESTS_BIN := $(BIN_ROOT)tests/
MAIN := texadamain

CC := g++
CFLAGS = -std=c++11 -I$(SPOT_INCL) -I$(GTEST_INCL) -I$(BOOST_INCL) -O2 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"  

# Add inputs and outputs from these tool invocations to the build variables 

SOURCE += \
 $(wildcard $(SRC)/*/*.cpp)

OBJS += \
 $(subst texada-src/src,texada-src/bin/src,$(patsubst %.cpp,%.o,$(SOURCE))) \

FILTER_OUT = $(foreach v,$(2),$(if $(findstring $(1),$(v)),,$(v)))
OBJS_NO_MAIN := $(call FILTER_OUT,$(MAIN),$(OBJS))

TEST_OBJS+= \
 $(subst texada-src/tests,texada-src/bin/tests, $(patsubst %.cpp,%.o,$(wildcard $(TESTS_SRC)*.cpp)))

mkdir=@mkdir -p $(@D)

# All Target
all: make-debug texada texadatest

make-debug:
	@echo 'Sources: $(SOURCE)'
	@echo
	@echo 'Objs: $(OBJS)'
	@echo

# Linking texadatest
texadatest: $(OBJS_NO_MAIN) $(TEST_OBJS)
	@echo 'Linking: $@'
	$(CC) -L$(SPOT_LIB) -L$(GTEST_LIB) -o  "texadatest" $(OBJS_NO_MAIN) $(TEST_OBJS) $(LIBS) 
	@echo 'Finished building target: $@'
	@echo ' '

# Linking texada
texada: $(OBJS)
	@echo 'Building: $@'
	$(CC) -L$(SPOT_LIB) -L$(GTEST_LIB) -o "texada" $(OBJS) $(LIBS) 
	@echo 'Finished building target: $@'
	@echo ' '

# Compiling non-testing code
$(OBJS): $(BIN)%.o: $(SRC)%.cpp
	$(mkdir)
	@echo 'Building: $<'
	$(CC) $(CFLAGS)
	@echo 'Finished building: $<'
	@echo ' '

# Compiling testing code
$(TEST_OBJS): $(TESTS_BIN)%.o: $(TESTS_SRC)%.cpp
	$(mkdir)
	@echo 'Building: $<'
	$(CC) $(CFLAGS)
	@echo 'Finished building: $<'
	@echo ' '

$(CHECKERS):
	mkdir -p $@
$(INST_TOOLS):
	mkdir -p $@
$(MAIN):
	mkdir -p $@
$(PARSING):
	mkdir -p $@	
$(TESTS):
	mkdir -p $@	

# Other Targets
clean:
	-$(RM) $(BIN_ROOT) texadatest texada
	-@echo ' '

.PHONY: all clean make-debug
