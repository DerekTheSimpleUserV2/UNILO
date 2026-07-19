#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
    FILE *f = fopen("/etc/os-release", "r");
    if (f) {
        char line[256];
        while (fgets(line, sizeof(line), f)) {
            if (strncmp(line, "NAME=", 5) == 0) {
                printf("Sistema detectado: %s", line+5);
            }
        }
        fclose(f);
    } else {
        printf("No se pudo detectar OS desde /etc/os-release\n");
    }

    system("uname -m"); // muestra arquitectura
    return 0;
}
