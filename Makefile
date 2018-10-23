NAME = hello-world

CC = /usr/bin/clang
MK = /bin/mkdir -p
MV = /bin/mv
RM = /bin/rm -f

NSRC = hello-world.c
NOBJ = $(NSRC:.c=.o)
NDEP = $(NSRC:.c=.d)

DSRC = srcs
DOBJ = .objs
DDEP = .deps

SRC = $(addprefix $(DSRC)/,$(NSRC))
OBJ = $(addprefix $(DOBJ)/,$(NOBJ))
DEP = $(addprefix $(DDEP)/,$(NDEP))

DDOBJ = $(sort $(dir $(OBJ)))
DDDEP = $(sort $(dir $(DEP)))

CFLAGS = -Wall -Wextra -Werror
DEPFLAGS = -MMD -MP -MF $(DDEP)/$*.Td

COMP = $(CC) $(CFLAGS)
POST_COMP = $(MV) $(DDEP)/$*.Td $(DDEP)/$*.d && touch $@

.SILENT:
.PHONY: all clean fclean

all:
	make -j $(NAME)

$(NAME): $(DDOBJ) $(DDDEP) $(OBJ) Makefile
	echo "Building Hello World!"
	$(COMP) -o $@ $(OBJ)
	echo "Done!"

$(DDOBJ):
	$(MK) $@

$(DDDEP):
	$(MK) $@

$(DOBJ)/%.o: $(DSRC)/%.c

$(DOBJ)/%.o: $(DSRC)/%.c $(DDEP)/%.d
	echo "Compiling $< into $@"
	$(COMP) $(DEPFLAGS) -o $@ -c $<
	$(POST_COMP)

$(DDEP)/%.d: ;
-include $(DEP)

clean:
	$(RM) -r $(DOBJ) $(DDEP)

fclean: clean
	$(RM) $(NAME)

re: fclean all
