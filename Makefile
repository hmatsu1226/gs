CXX := g++
INC := -Ilib
LIB := -Llib -llapacke -llapack -lcblas -lrefblas -lgfortran -lm
CXXFLAGS += -O3
CXXFLAGS += -std=c++1z
#CXXFLAGS += -std=c++11
CXXFLAGS += -march=native
CXXFLAGS += -fno-exceptions
CXXFLAGS += -Wall

all: gs2

gs2: messages.cpp format.cpp eigen.cpp mmseqs.cpp gs_functions.cpp sc_functions.cpp sc.cpp ep.cpp gs.cpp main.cpp
	$(CXX) $(CXXFLAGS) $(INC) -o $@ $^ $(LIB)	

clean:
	$(RM) main
	$(RM) format
	$(RM) mmseqs
	$(RM) gs
	$(RM) ep
	$(RM) sc
	$(RM) gs_functions
	$(RM) sc_functions
	$(RM) eigen
	$(RM) messages
