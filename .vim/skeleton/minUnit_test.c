#include <stdio.h>
#include <stdbool.h>

/* MinUnit source */
#define mu_assert(message, test) do { if (!(test)) return message; } while (0)
#define mu_run_test(test) do { char *message = test(); tests_run++; \
	if (message) return message; } while (0)

int tests_run = 0;

static char* test() {
	mu_assert("Fail Message", true);
	return 0;
}

static char* all_tests() {
	mu_run_test(test);
	return 0;
}

int main(int argc, char **argv) {
	char *result = all_tests();

	if (result != 0) {
		printf("%s\n", result);
	} else {
		printf("ALL TESTS PASSED\n");
	}

	printf("Tests run: %d\n", tests_run);
	return result != 0;
}