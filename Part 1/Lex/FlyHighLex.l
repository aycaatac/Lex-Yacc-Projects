esc_seq \\[0\"\'\\nt]
%%
\/\/.*                       printf("EOL_COMMENT");
\,                           printf("COMMA");
\;                           printf("SC");
int                          printf("INT_T");
float                        printf("FLOAT_T");
char                         printf("CHAR_T");
string                       printf("STRING_T");
bool                         printf("BOOL_T");
if                           printf("IF");
else                         printf("ELSE");
true                         printf("TRUE");
false                        printf("FALSE");
while                        printf("WHILE");
return                       printf("RETURN");
break                        printf("BREAK");
void                         printf("VOID");
print                         printf("PRINT");
input                     printf("INPUT");
main                      printf("MAIN");
getHeading                printf("GET_HEADING"); 
getAltitude               printf("GET_ALTITUDE");
getTime                   printf("GET_TIME"); 
manageNozzle              printf("MANAGE_NOZZLE"); 
verticalMovement          printf("VERTICAL_MOVEMENT");
moveUp                    printf("MOVE_UP");
moveDown                   printf("MOVE_DOWN");
stop                       printf("STOP");
turnNozzleOn              printf("TURN_NOZZLE_ON");
turnNozzleOff             printf("TURN_NOZZLE_OFF");
horizontalMovement        printf("HORIZONTAL_MOVEMENT"); 
turnHeading               printf("TURN_HEADING"); 
turnLeft                  printf("TURN_LEFT"); 
turnRight                 printf("TURN_RIGHT"); 
moveForward               printf("MOVE_FORWARD"); 
moveBackward              printf("MOVE_BACKWARD"); 
moveDrone                 printf("MOVE_DRONE");
eqTriangle                printf("EQ_TRIANGLE");
moveForDuration             printf("MOVE_FOR_DURATION");
sprayField                printf("SPRAY_FIELD");
\&\&                           printf("AND_OP");
\|\|                           printf("OR_OP");
\=\=                           printf("EQ");
\!\=                           printf("NEQ");
\<                            printf("LT");
\<\=                           printf("LTE");
\>                            printf("GT");
\>\=                           printf("GTE");
\(                            printf("LP");
\)                            printf("RP");
\{                            printf("LCB");
\}                            printf("RCB");
\=                            printf("ASSIGN_OP");
\+                            printf("PLU_OP");
\-                            printf("MIN_OP");
\*                            printf("MUL_OP");
\/                            printf("DIV_OP");
[+-]?[0-9]+                 printf("INT");
[+-]?[0-9]*[.][0-9]+        printf("FLOAT");
_[a-zA-Z][a-zA-Z0-9]*      printf("BOOL_IDENTIFIER");
[a-zA-Z][a-zA-Z0-9]*      printf("IDENTIFIER");
\"[^\"]*\"                  printf("STRING");
\'({esc_seq}|[^'\\])\'       printf("CHAR");
[ ]+                     printf(" ");
[\t]+                    printf("\t");
[\n]+                      printf("\n");
[\r]+     ;
.                       printf("unknown: >%s< !", yytext);
%%
int yywrap() {
    return 1;
}
int main() {
    yylex();
    return 0;
} 
