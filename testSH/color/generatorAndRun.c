#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>

extern int system(const char*);

void main()
{
	int i, j, n, k, p=20;
	char strbuf[1024], logfile[128];
	FILE *outc, *outd, *log;
	struct timeval start, end;
	double time;
	srand(8793);
	for (k=5; k<=30; k+=5)
	{
		for (n=1; n<=5; n++)
		{
			sprintf(strbuf, "colorfactclaspD%d_%d.lp", k, n);
			if (NULL==(outc=fopen(strbuf, "w")) )
			{
				assert(0);
			}
			sprintf(strbuf, "colorfactDLV%d_%d.lp", k, n);
			if ( NULL==(outd=fopen(strbuf, "w")) )
			{
				assert(0);
			}
			fprintf(outd, "#maxint=%d.\n", k);
			fprintf(outd, "#const n=%d.\n", k);
			fprintf(outd, "vtx(1..%d).\n", k);

      fprintf(outc, "#hide.\n");
			fprintf(outc, "#show color/1.\n");
      fprintf(outc, "vtx(1..%d).\n", k);
      fprintf(outc, "min_vtx(%d).\n", 1);
			fprintf(outc, "max_vtx(%d).\n", k);


			for (i=1; i<=k; i++)
			{
				for (j=1; j<i; j++)
				{
					if (rand()%100 < p)
					{
						fprintf(outc, "edge(%d,%d). edge(%d,%d).\n", i, j, j, i);
						fprintf(outd, "edge(%d,%d). edge(%d,%d).\n", i, j, j, i);
					}
				}
			}
			fclose(outc);
			fclose(outd);

			sprintf(logfile, "color%d_to.log", p);
			sprintf(strbuf, "gringo colorfactclaspD%d_%d.lp color_claspD.lp | claspD  >> %s",  k, n, logfile);
			log = fopen(logfile, "a+");
			fprintf(log, "\n%s\n", strbuf);
			printf("\n%s\n", strbuf);
			gettimeofday(&start, NULL);
			fclose(log);
			system(strbuf);
			gettimeofday(&end, NULL);
			time = (end.tv_sec-start.tv_sec)+(end.tv_usec-start.tv_usec)/1000000.0;
			log = fopen(logfile, "a+");
			fprintf(log, "ClaspD cost %f seconds.\n", time);
			printf("ClaspD cost %f seconds.\n", time);
			fclose(log);

			sprintf(strbuf, "timeout 60 ./dlv -n=1 -filter=clr colorfactDLV%d_%d.lp color_dlv.lp >> %s", k, n, logfile);
			log = fopen(logfile, "a+");
			fprintf(log, "\n%s\n", strbuf);
			printf("\n%s\n", strbuf);
			gettimeofday(&start, NULL);
			fclose(log);
			system(strbuf);
			gettimeofday(&end, NULL);
			time = (end.tv_sec-start.tv_sec)+(end.tv_usec-start.tv_usec)/1000000.0;
			log = fopen(logfile, "a+");
			fprintf(log, "DLV cost %f seconds.\n", time);
			printf("DLV cost %f seconds.\n", time);
			fclose(log);
		}
	}
}
