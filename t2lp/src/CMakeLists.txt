PROJECT (zhou)

AUX_SOURCE_DIRECTORY (. zhou_src)

ADD_LIBRARY(Common Cabalar.cpp CabalarUtils.cpp 
			Formula.cpp Formulas.cpp global.cpp HengZhang.cpp lex.cpp NNFUtils.cpp parse.cpp PNFUtils.cpp
			Rule.cpp SMTranslator.cpp Utils.cpp Vocabulary.cpp
			)