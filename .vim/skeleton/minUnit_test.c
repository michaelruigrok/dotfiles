#include <stdio.h>
#include <stdbool.h>

/* MinUnit source */
#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { const char *message = test(); tests_run++; \
	if (message) return message; } while (0)

//Empty function to help with debugging
static void break_here(void) {
}

static int tests_run = 0;

static const char* test() {
	mu_assert("Fail Message", true);
	return 0;
}

static const char* all_tests() {
	mu_run_test(test);
	return 0;
}

int main(int argc, char **argv) {
	const char *result = all_tests();

	if (result != 0) {
		printf("%s\n", result);
	} else {
		printf("ALL TESTS PASSED\n");
	}

	printf("Tests run: %d\n", tests_run);
	return result != 0;
}
