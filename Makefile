# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: albrusso <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/01/30 16:21:18 by albrusso          #+#    #+#              #
#    Updated: 2024/10/01 16:17:37 by albrusso         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

################################################################################
#                                  CONFIG                                      #
################################################################################

MANDATORY	=	push_swap
BONUS	=	checker
CC		=	cc
CFLAGS	=	-Wall -Wextra -Werror
GNL		=	bonus/get_next_line/get_next_line.a
OBJ_DIR	=	.obj
SIZE	=	40

################################################################################
#                                  COLORS                                      #
################################################################################

RED		=	\033[1;31m
YELLOW	=	\033[1;33m
BLUE	=	\033[1;34m
GREEN	=	\033[1;32m
WHITE	=	\033[1;37m
DEFAULT	=	\033[0m

################################################################################
#                                   FILES                                      #
################################################################################

SRC_MANDATORY	=	mandatory/function_evaluate_two.c        \
					mandatory/function_evaluate.c            \
					mandatory/function_for_order.c           \
					mandatory/function_lst_one.c             \
					mandatory/function_lst_two.c             \
					mandatory/function_utils_two.c           \
					mandatory/function_utils.c               \
					mandatory/main.c                         \
					mandatory/new_argc.c                     \
					mandatory/rules_push.c                   \
					mandatory/rules_reverse_rotate.c         \
					mandatory/rules_rotate.c                 \
					mandatory/rules_swap.c                   \
					mandatory/split_two.c                    \
					mandatory/split.c                        \
					mandatory/table_three.c                  \
					mandatory/table_two.c                    \
					mandatory/table.c

SRC_BONUS		=	mandatory/function_evaluate_two.c        \
					mandatory/function_evaluate.c            \
					mandatory/function_for_order.c           \
					mandatory/function_lst_one.c             \
					mandatory/function_lst_two.c             \
					mandatory/function_utils_two.c           \
					mandatory/function_utils.c               \
					mandatory/new_argc.c                     \
					mandatory/rules_push.c                   \
					mandatory/rules_reverse_rotate.c         \
					mandatory/rules_rotate.c                 \
					mandatory/rules_swap.c                   \
					mandatory/split_two.c                    \
					mandatory/split.c                        \
					mandatory/table_three.c                  \
					mandatory/table_two.c                    \
					mandatory/table.c                        \
					bonus/function_to_execute_rules.c        \
					bonus/main_bonus.c

OBJ_MANDATORY	=	$(addprefix $(OBJ_DIR)/, $(SRC_MANDATORY:.c=.o))
OBJ_BONUS		=	$(addprefix $(OBJ_DIR)/, $(SRC_BONUS:.c=.o))

################################################################################
#                                   MAKE                                       #
################################################################################

all:	$(MANDATORY)
$(MANDATORY): $(OBJ_MANDATORY)
	@$(CC) $(CFLAGS) $(OBJ_MANDATORY) -o $(MANDATORY)

$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	@printf "$(WHITE)%s$(BLUE)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Compiling... " "$<" "[OK]"
	@$(CC) $(CFLAGS) -c $< -o $@

bonus:	$(OBJ_BONUS)
	@make -sC bonus/get_next_line
	@$(CC) $(CFLAGS) $(OBJ_BONUS) $(GNL) -o $(BONUS)

$(OBJ_DIR)/%.o: %.c | $(OBJ_DIR)
	@printf "$(WHITE)%s$(BLUE)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Compiling... " "$<" "[OK]"
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)
	@mkdir -p $(OBJ_DIR)/mandatory
	@mkdir -p $(OBJ_DIR)/bonus

clean:
	@make clean -sC bonus/get_next_line
	@for file in $(OBJ_MANDATORY); do \
		printf "$(WHITE)%s$(YELLOW)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Removing...  " "$$file" "[OK]"; \
	done
	@for file in $(OBJ_BONUS); do \
		printf "$(WHITE)%s$(YELLOW)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Removing...  " "$$file" "[OK]"; \
	done
	@rm -f $(OBJ_MANDATORY)
	@rm -f $(OBJ_BONUS)
	@rm -rf $(OBJ_DIR)

fclean: clean
	@printf "$(WHITE)%s$(RED)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Removing...  " "get_next_line.a" "[OK]"
	@rm -f $(GNL)
	@printf "$(WHITE)%s$(RED)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Removing...  " "$(MANDATORY)" "[OK]"
	@rm -f $(MANDATORY)
	@printf "$(WHITE)%s$(RED)%-$(SIZE)s$(GREEN)%s$(DEFAULT)\n" "Removing...  " "$(BONUS)" "[OK]"
	@rm -f $(BONUS)
re: fclean all

run: $(MANDATORY)
	./$(MANDATORY)

mem: $(MANDATORY)
		@valgrind --quiet --leak-check=full ./$(MANDATORY) map/map1.ber

.PHONY: all clean fclean re run mem
