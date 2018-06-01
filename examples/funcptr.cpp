#include <stdio.h>

int square(int a) {
    return a * a;
}
 
int main() {
    int (*square_ptr)(int) = square;
 
    printf("%d\n", (*square_ptr)(10));
}