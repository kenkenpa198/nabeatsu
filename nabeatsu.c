/****************************************
 * nabeatsu
 * 引数として与えられた整数が 3 で割り切れる または 文字列に 3 を含む場合「num!!!」と出力する
 *
 ****************************************/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int main(int argc, char** argv) {

    // 検証エラーの際に出力する文字列を初期化
    char errorMessage[] = "引数へ整数を 1 つだけ指定して実行してください";

    // 引数の数を検証する
    if (argc != 2) {
        printf("%s\n", errorMessage);
        return 1;
    }

    // 引数に与えられた文字列が数値であるか検証する
    int argvLen = strlen(argv[1]);
    for (int i = 0; i < argvLen; i++) {
        if (!isdigit(argv[1][i])) {
            printf("%s\n", errorMessage);
            return 1;
        }
    }

    // 文字列として受け取った引数を整数へ変換する
    int num = atoi(argv[1]);

    // 整数が 3 で割り切れる または 文字列に 3 を含む場合「num!!!」と出力する
    if (num % 3 == 0 || strstr(argv[1], "3") != NULL) {
        printf("%d!!!\n", num);
    } else {
        printf("%d\n", num);
    }

    return 0;
}
