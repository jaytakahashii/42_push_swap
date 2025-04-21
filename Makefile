MAKEFILE = Makefile

NAME = push_swap

SRC_DIR = src/
OBJ_DIR = .obj/

LIBFT_DIR = libft/
LIBFT_NAME = libft.a

INCLUDE_DIR = include/
INCLUDE = -I $(INCLUDE_DIR)
LIBFT_INCLUDE = -I $(LIBFT_DIR)$(INCLUDE_DIR)

CC = cc
CFLAGS = -Wall -Wextra -Werror
PEDANTIC = --pedantic
SANITIZE = -fsanitize=address

RM = rm -rf
NORM = norminette

COMMAND_UTILS_DIR = command_utils/
COMMAND_UTILS_SRC = command_utils.c \
										command_utils2.c \
										command_utils3.c

STACK_UTILS_DIR = stack_utils/
STACK_UTILS_SRC = stack_management.c \
									stack_info.c \
									stack_checker.c

MAIN_DIR	= main/
MAIN_SRC	= main.c\
						push_swap.c\
						sort.c

OPERATIONS_DIR	= operations/
OPERATIONS_SRC	= swap.c\
									rotate.c\
									reverse_rotate.c\
									push.c

UTILS_DIR = utils/
UTILS_SRC = push_swap_atoi.c\
						error.c

SRC_FILES += $(addprefix $(COMMAND_UTILS_DIR), $(COMMAND_UTILS_SRC))
SRC_FILES += $(addprefix $(STACK_UTILS_DIR), $(STACK_UTILS_SRC))
SRC_FILES += $(addprefix $(MAIN_DIR), $(MAIN_SRC))
SRC_FILES += $(addprefix $(OPERATIONS_DIR), $(OPERATIONS_SRC))
SRC_FILES += $(addprefix $(UTILS_DIR), $(UTILS_SRC))

OBJ_FILES = $(SRC_FILES:%.c=%.o)

SRCS += $(addprefix $(SRC_DIR), $(SRC_FILES))
OBJS += $(addprefix $(OBJ_DIR), $(OBJ_FILES))

Y 			= "\033[33m"
R 			= "\033[31m"
G 			= "\033[32m"
B 			= "\033[34m"
X 			= "\033[0m"
UP 			= "\033[A"
CUT 		= "\033[K"

all: $(NAME)

$(NAME): $(OBJ_DIR) $(OBJS)
	@$(MAKE) -C $(LIBFT_DIR)
	$(CC) $(CFLAGS) $(OBJS) $(LIBFT_DIR)$(LIBFT_NAME) -o $(NAME)
	@echo $(G) "!! $(NAME) created !!" $(X)

$(OBJ_DIR):
	@mkdir $(OBJ_DIR)
	@mkdir $(OBJ_DIR)$(COMMAND_UTILS_DIR)
	@mkdir $(OBJ_DIR)$(STACK_UTILS_DIR)
	@mkdir $(OBJ_DIR)$(MAIN_DIR)
	@mkdir $(OBJ_DIR)$(OPERATIONS_DIR)
	@mkdir $(OBJ_DIR)$(UTILS_DIR)

$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) $(INCLUDE) $(LIBFT_INCLUDE) -c $< -o $@

clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	$(RM) $(OBJ_DIR)
	@echo $(R) "$(OBJ_DIR) has been removed.\n" $(X)

fclean:
	@$(MAKE) -C $(LIBFT_DIR) fclean
	$(RM) $(OBJ_DIR)
	$(RM) $(NAME)
	@echo $(R) "$(NAME) and $(OBJ_DIR) has been removed.\n" $(X)

re: fclean all

pedantic: CFLAGS += $(PEDANTIC)
pedantic: re
	@echo $(G) "pedantic mode activated.\n" $(X)

leaks: CFLAGS += $(SANITIZE)
leaks: re
	@echo $(G) "leaks mode activated.\n" $(X)

norm:
	@echo $(R) "<<< push_swap error count >>>" $(X)
	@norminette $(SRC_FILES) $(INCLUDE_DIR) | grep Error | wc -l
	@norminette $(SRC_FILES) $(INCLUDE_DIR) | grep Error || true
	@echo "\n"
	@$(MAKE) -C $(LIBFT_DIR) norm

.PHONY: all clean fclean re norm
