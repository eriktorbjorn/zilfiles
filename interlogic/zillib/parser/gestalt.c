#include <stdio.h>
#include <stdlib.h>
#include <string.h>
/*************************************************************************/
/*                            GESTALT.C                                  */
/*        written by John W. Ratcliff and David E. Metzener              */
/*                         November 10, 1987                             */
/*                                                                       */
/* Demonstrates the Ratcliff/Obershelp Pattern Recognition Algorithm     */
/* Link this with SIMIL.OBJ created from the SIMIL.ASM source file       */
/* The actual similiarity function is called as:                         */
/* int simil(char *str1,char *str2)                                      */
/* where str1 and str2 are the two strings you wish to know their        */
/* similiarity value.  simil returns a percentage match between          */
/* 0 and 100 percent.                                                    */
/*************************************************************************/
int     simil(char *str1,char *str2);
void    ucase(char *str);

main()
{
  char  str1[80];
  char  str2[80];
  int   prcnt;

printf("This program demonstrates the Ratcliff/Obershelp pattern\n");
printf("recognition algorithm.  Enter series of word pairs to\n");
printf("discover their similarity values.\n");
printf("Enter strings of 'END' and 'END' to exit.\n\n");
do
  {
    printf("Enter the two strings seperated by a space: ");
    scanf("%s %s",str1,str2);
    ucase(str1);
    ucase(str2);
    prcnt = simil(str1,str2);
    printf("%s and %s are %d\% alike.\n\n",str1,str2,prcnt);
  } while (strcmp(str1,"END"));
}

void ucase(str)
char *str;
{
  while (*str)
  {
   *str=toupper(*str);
   str++;
  }
}
