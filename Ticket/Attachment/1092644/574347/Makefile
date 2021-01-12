CC=gcc
CFLAGS+=-Wall -g

TARGET=test_embed_perl

$(TARGET): $(TARGET).o
	$(CC) $(OPT) $^ -o $@ `perl -MExtUtils::Embed -e ldopts`

$(TARGET).o: $(TARGET).c
#	$(CC) $(CFLAGS) -E $< -o expo-test.ccc -I"c:/camelbox/lib/CORE" `perl -MExtUtils::Embed -e ccopts`
	$(CC) $(CFLAGS) -c $< `perl -MExtUtils::Embed -e ccopts`

clean:
	rm -f $(TARGET).o $(TARGET)

