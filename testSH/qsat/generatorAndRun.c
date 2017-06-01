#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>

#define MAX_NUM_CLAUSE	1024
#define MAX_NUM_ATOM	256

extern int system(const char*);

int num_clause_dnf, num_clause_cnf, num_variable;
int dnf[MAX_NUM_CLAUSE][MAX_NUM_ATOM];
int cnf[MAX_NUM_CLAUSE][MAX_NUM_ATOM];

int is_inferable()
{
	long long k;
	int i, j, t_dnf, t_cnf, t_inf, t;
	int assignment[128];

	printf("\nEnter inferable...%ld\n", sizeof(k));

	if (num_variable>=64) return -1;

	for (k=0,t_inf=1; t_inf && k<(1<<num_variable); k++)
	{
		if (0==k%1000000) printf("%dx%d\n", (int)(k>>32), (int)k);
		for (i=0; i<num_variable; i++)
			assignment[i] = (k>>i) & 1;

		for (i=0,t_dnf=0; !t_dnf && i<num_clause_dnf; i++)
		{
			for (j=0,t=1; t && j<num_variable; j++)
			{
				t = (1==assignment[j] || 1!=dnf[i][j]) &&
				    (0==assignment[j] ||-1!=dnf[i][j]);
			}
			t_dnf = t;
		}

		if (!t_dnf) continue;

		for (i=0,t_cnf=1; t_cnf && i<num_clause_cnf; i++)
		{
			for (j=0,t=0; !t && j<num_variable; j++)
			{
				t = (1==assignment[j] &&  1==cnf[i][j]) ||
				    (0==assignment[j] && -1==cnf[i][j]);
			}
			t_cnf = t;
		}

		t_inf = t_cnf;
	}
	printf("Exit inferable...\n");

	return t_inf;
}
/*
void main()
{
	num_variable = 8;
	num_clause_dnf = 2;
	num_clause_cnf = 3;
	dnf[0][0] = 1;
	dnf[0][1] = 1;
	dnf[1][0] = 1;
	dnf[1][1] = 1;
	cnf[0][0] = 1;
	cnf[1][1] = 1;
	cnf[2][0] = 1;

	printf("Inferable = %d.\n", is_inferable());
}
*/

void main()
{
	int i, j, m, n, r, k, s;
	char strbuf[1024],strbuf0[1024],logname[128];
	FILE *outc, *outd, *qbf;
	struct timeval start, end;
	double time;
	int num_var[] = {5, 10, 15, 20, 25, 30};
	int num_ccl[] = {5, 10, 15, 20, 25, 30};
	int num_dcl[] = {5, 10, 15, 20, 25,30};

	srand(8594);

	for (m=0; m<sizeof(num_var)/sizeof(num_var[0]); m++)
	{
		for (n=1; n<=5; n++)
		{
			sprintf(strbuf, "qsatclaspD%d_%d.lp", num_var[m], n);
			if ( NULL==(outc=fopen(strbuf, "w")) )
			{
				assert(0);
			}
			sprintf(strbuf, "qsatdlv%d_%d.lp", num_var[m], n);
			if ( NULL==(outd=fopen(strbuf, "w")) )
			{
				assert(0);
			}
			num_variable = num_var[m];
			num_clause_dnf = num_ccl[m];
			num_clause_cnf = num_dcl[m];
			for (i=0; i<num_clause_dnf; i++)
				for (j=0; j<num_variable; j++)
					dnf[i][j] = 0;
			for (i=0; i<num_clause_cnf; i++)
				for (j=0; j<num_variable; j++)
					cnf[i][j] = 0;

			fprintf(outd, "#maxint=%d.\n", 1024);
			fprintf(outd, "#const n=%d.\n", num_variable);
			fprintf(outd, "#const m=%d.\n", (num_variable>>1)+1);
			fprintf(outd, "#const k=%d.\n", num_clause_cnf);
			fprintf(outd, "#const l=%d.\n", num_clause_dnf);

			fprintf(outc, "atom(1..%d).\n", num_variable);
			fprintf(outc, "un(1..%d).\n", (num_variable>>1)+1);
			fprintf(outc, "conj(1..%d).\n", num_clause_cnf);
			fprintf(outc, "disj(1..%d).\n", num_clause_dnf);
			fprintf(outc, "min_atom(1).\n");
			fprintf(outc, "max_atom(%d).\n",num_variable);
			fprintf(outc, "min_un(1).\n");
			fprintf(outc, "max_un(%d).\n",(num_variable>>1)+1);
			fprintf(outc, "min_conj(1).\n");
			fprintf(outc, "max_conj(%d).\n",num_clause_cnf);
			fprintf(outc, "min_disj(1).\n");
			fprintf(outc, "max_disj(%d).\n",num_clause_dnf);



			for (i=1; i<=num_clause_dnf; i++)
			{
				k = rand() % ((int)(num_variable*15/100) + 1);
				for (; k>=0; k--)
				{
					do
					{
						r = (rand() % num_variable) + 1;
					} while (0!=dnf[i-1][r-1]);
					s = (rand() % 2);
					if (1 == s)
					{
						fprintf(outc, "posd(%d,%d).\n", i, r);
						fprintf(outd, "posd(%d,%d).\n", i, r);
						dnf[i-1][r-1] = 1;
					}
					else
					{
						fprintf(outc, "negd(%d,%d).\n", i, r);
						fprintf(outd, "negd(%d,%d).\n", i, r);
						dnf[i-1][r-1] = -1;
					}
				}
			}

			for (i=1; i<=num_clause_cnf; i++)
			{
				k = rand() % ((int)(num_variable*30/100) + 1);
				for (; k>=0; k--)
				{
					do
					{
						r = (rand() % num_variable) + 1;
					} while (0!=cnf[i-1][r-1]);
					s = (rand() % 2);
					if (1 == s)
					{
						fprintf(outc, "posc(%d,%d).\n", i, r);
						fprintf(outd, "posc(%d,%d).\n", i, r);
						cnf[i-1][r-1] = 1;
					}
					else
					{
						fprintf(outc, "negc(%d,%d).\n", i, r);
						fprintf(outd, "negc(%d,%d).\n", i, r);
						cnf[i-1][r-1] = -1;
					}
				}
			}

			fclose(outc);
			fclose(outd);

			sprintf(logname, "qt2122.log");

			sprintf(strbuf, "gringo qsatclaspD%d_%d.lp qsat_claspD.lp | claspD  >> %s", num_var[m], n, logname);
			qbf = fopen(logname, "a+");
			fprintf(qbf, "\n%s\n", strbuf);
			printf("\n%s\n", strbuf);
			fclose(qbf);
			gettimeofday(&start, NULL);
			system(strbuf);
			gettimeofday(&end, NULL);
			time = (end.tv_sec-start.tv_sec)+(end.tv_usec-start.tv_usec)/1000000.0;
			qbf = fopen(logname, "a+");
			fprintf(qbf, "ClaspD cost %f seconds.\n", time);
			printf("ClaspD cost %f seconds.\n", time);
			fclose(qbf);

			sprintf(strbuf, "timeout 60 ./dlv -n=1 -filter=true qsatdlv%d_%d.lp qsat_dlv.lp >> %s", num_var[m], n, logname);
			qbf = fopen(logname, "a+");
			fprintf(qbf, "\n%s\n", strbuf);
			printf("\n%s\n", strbuf);
			fclose(qbf);
			gettimeofday(&start, NULL);
			system(strbuf);
			gettimeofday(&end, NULL);
			time = (end.tv_sec-start.tv_sec)+(end.tv_usec-start.tv_usec)/1000000.0;
			qbf = fopen(logname, "a+");
			fprintf(qbf, "DLV cost %f seconds.\n", time);
			printf("DLV cost %f seconds.\n", time);

			fclose(qbf);
		}
	}
}
