#include <stdio.h>
#include <stdlib.h>
typedef struct Customer{
    int id;
    int age;
    int payments[5];
}CUSTOMER;

typedef struct Employee{
    char name[8];
    int salary;
}EMPLOYEE;


int sumOfPowers(int n);                                 //this function should find the following sum: 1^2 + 2^2 + 3^2 + 4^2 + ... + n^2
int compareAges(CUSTOMER* a, CUSTOMER* b);              //this function should test if  a->age == b->age. it returns 1 if they are equal; 0 otherwise.
int findPaymentsSum(CUSTOMER* c, int num_of_pamyments); //this function should find the sum of all payments made by a given customer

// extra credit
int findSalariesSum(EMPLOYEE e[], int size);            //this function should find the sum of salaries in a given array of employees

int main(){
    
    // TestCase-1
    printf("The sum is: %d\n",sumOfPowers(3));

    // TestCase-2
    /*
    CUSTOMER* a1=malloc(sizeof(CUSTOMER));
    CUSTOMER* a2=malloc(sizeof(CUSTOMER));
    CUSTOMER* a3=malloc(sizeof(CUSTOMER));
    a1->age=25;
    a2->age=30;
    a3->age=25;
    printf("The result of the comparison is: %d\n",compareAges(a1,a2));
    printf("The result of the comparison is: %d\n",compareAges(a1,a3));
    */

    // TestCase-3
    /*
    CUSTOMER* cstmr=malloc(sizeof(CUSTOMER));
    cstmr->id=101;
    cstmr->age=30;
    cstmr->payments[0]=1500;
    cstmr->payments[1]=1500;
    cstmr->payments[2]=2000;
    cstmr->payments[3]=500;
    cstmr->payments[4]=300;
    printf("The sum of all payments is: %d\n",findPaymentsSum(cstmr, 5));
    */

    // TestCase-4
    
    EMPLOYEE e1={"jame",2000}, e2={"sara",3000}, e3={"alic",2500}, e4={"mark",3200};
    EMPLOYEE employees[4]={e1,e2,e3,e4};
    printf("The sum of salaries is: %d\n",findSalariesSum(employees,4));
    

}