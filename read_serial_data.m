a = 0;
s = serial('COM3','BaudRate',9600,'Databits',8);
p1= [0;3;9];
p2= [0;3;4];
p3= [0;8;4];
p4= [0;8;9];
p5= [5;3;9];
p6= [5;3;4];
p7= [5;8;4];
p8= [5;8;9];
fopen(s);
%throw the first badge as it may contain garbage
r1 = fscanf(s);
r2 = fscanf(s);
r3 = fscanf(s);
while a < 200 
 r1 = str2num(fscanf(s))/180 * 22/7
 r2 = str2num(fscanf(s))/180 * 22/7
 r3 = str2num(fscanf(s))/180 * 22/7
 arb3 = [cos(r3), -sin(r3), 0; sin(r3), cos(r3), 0; 0, 0, 1];
 arb2 = [cos(r2), 0, -sin(r2); 0, 1, 0; sin(r2), 0, cos(r2)];
 arb1=[1,0,0; 0, cos(r1),sin(r1); 0,sin(r1),cos(r1)];
 arb = arb3*(arb2*arb1);
 
 P1=arb*p1;
 P2=arb*p2;
 P3=arb*p3; 
 P4=arb*p4;
 P5=arb*p5;
 P6=arb*p6;
 P7=arb*p7; 
 P8=arb*p8;

 
cara1x=[P1(1),P2(1),P3(1),P4(1)];
cara1y=[P1(2),P2(2),P3(2),P4(2)];
cara1z=[P1(3),P2(3),P3(3),P4(3)];
cara2x=[P4(1),P3(1),P7(1),P8(1)];
cara2y=[P4(2),P3(2),P7(2),P8(2)];
cara2z=[P4(3),P3(3),P7(3),P8(3)];
cara3x=[P8(1),P7(1),P6(1),P5(1)];
cara3y=[P8(2),P7(2),P6(2),P5(2)];
cara3z=[P8(3),P7(3),P6(3),P5(3)];
cara4x=[P5(1),P6(1),P2(1),P1(1)];
cara4y=[P5(2),P6(2),P2(2),P1(2)];
cara4z=[P5(3),P6(3),P2(3),P1(3)];
cara5x=[P1(1),P4(1),P8(1),P5(1)];
cara5y=[P1(2),P4(2),P8(2),P5(2)];
cara5z=[P1(3),P4(3),P8(3),P5(3)];
cara6x=[P2(1),P3(1),P7(1),P6(1)];
cara6y=[P2(2),P3(2),P7(2),P6(2)];
cara6z=[P2(3),P3(3),P7(3),P6(3)];
patch(cara1x,cara1y,cara1z,[0 1 0])
patch(cara2x,cara2y,cara2z,[0.6350 0.0780 0.1840])
patch(cara3x,cara3y,cara3z,[0.6350 0.0780 0.1840])
patch(cara4x,cara4y,cara4z,[0.6350 0.0780 0.1840])
patch(cara5x,cara5y,cara5z,[0.6350 0.0780 0.1840])
patch(cara6x,cara6y,cara6z,[0.6350 0.0780 0.1840])
 axis([-20,20,-20,20,-20,20]);
 grid on;
 pause(0.1);
 a = a+1;
 clf
end
fclose(s);


 
 

