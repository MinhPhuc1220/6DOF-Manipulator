function dMthei = Com_dMthei(M, the, i)

dMthei = 0.5*[ Chrstffel(M,the,i,1,1), Chrstffel(M,the, i,1,2), Chrstffel(M,the,i,1,3), Chrstffel(M,the,i,1,4), Chrstffel(M,the,i,1,5), Chrstffel(M,the,i,1,6);
               Chrstffel(M,the,i,2,1), Chrstffel(M,the, i,2,2), Chrstffel(M,the,i,2,3), Chrstffel(M,the,i,2,4), Chrstffel(M,the,i,2,5), Chrstffel(M,the,i,2,6);
               Chrstffel(M,the,i,3,1), Chrstffel(M,the, i,3,2), Chrstffel(M,the,i,3,3), Chrstffel(M,the,i,3,4), Chrstffel(M,the,i,3,5), Chrstffel(M,the,i,3,6);
               Chrstffel(M,the,i,4,1), Chrstffel(M,the, i,4,2), Chrstffel(M,the,i,4,3), Chrstffel(M,the,i,4,4), Chrstffel(M,the,i,4,5), Chrstffel(M,the,i,4,6);
               Chrstffel(M,the,i,5,1), Chrstffel(M,the, i,5,2), Chrstffel(M,the,i,5,3), Chrstffel(M,the,i,5,4), Chrstffel(M,the,i,5,5), Chrstffel(M,the,i,5,6);
               Chrstffel(M,the,i,6,1), Chrstffel(M,the, i,6,2), Chrstffel(M,the,i,6,3), Chrstffel(M,the,i,6,4), Chrstffel(M,the,i,6,5), Chrstffel(M,the,i,6,6)];