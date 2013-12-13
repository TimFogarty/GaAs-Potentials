/*==========================================================
 * potential.c - Potential of random chagres on a disc
 *
 * For a grid of points along x-axis (x) and y-axis (y), 
 * calculates the potential due to randomly distributed
 * charges (poistion given in charges) at a distance (d)
 * from the charges. a is the constant
 * q/(4pi\epsilon_0\epsilon).
 * Outputs a NxN matrix (outMatrix).
 *
 * The calling syntax is:
 *
 *		outMatrix = potential(x, y, charges, d, a)
 *
 * This is a MEX-file for MATLAB.
 *
 * Authored by Tim Fogarty, University of Nottingham
 * https://github.com/TimFogarty/GaAs-Potentials
 *
 *========================================================*/

#include "mex.h"
#include <math.h>

/* The computational routine */
void potential(double a, double d, double *x, double *y, double *charge, double *outMatrix, mwSize sizeX, mwSize chargeRows, mwSize sizeCharge)
{
    mwSize i,j,k;
    mwSize chargeCols = sizeCharge/chargeRows;

    for (i = 0; i < sizeX; i++) {
	for (j = 0; j < sizeX; j++) {
	    for (k = 0; k < chargeCols; k++){
		
		outMatrix[i + j*sizeX] += a/sqrt(pow(d,2) + pow((x[i] - charge[k*chargeRows]),2) + pow((y[j] - charge[1 + k*chargeRows]),2));
		
	    }
	}
	mexPrintf("%d\n", sizeX - i);
	mexEvalString("drawnow;");
    }
}

/* The gateway function */
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    double d;
    double a;
    double *xMatrix;              /* input scalar */
    double *yMatrix;
    size_t sizeX;
    double *chargeMatrix;               /* 1xN input matrix */
    size_t sizeCharge;                   /* size of matrix */
    size_t chargeRows;
    double *outMatrix;              /* output matrix */

    /* check for proper number of arguments */
    if(nrhs!=5) {
	mexErrMsgIdAndTxt("MyToolbox:potential:nrhs","3 inputs required.");
    }
    if(nlhs!=1) {
	mexErrMsgIdAndTxt("MyToolbox:potential:nlhs","One output required.");
    }
    
    /* make sure the first input argument is type double */
    if( !mxIsDouble(prhs[0]) || 
	mxIsComplex(prhs[0])) {
	mexErrMsgIdAndTxt("MyToolbox:potential:notDouble","Input matrix must be type double.");
    }
    
    /* make sure the second input argument is type double */
    if( !mxIsDouble(prhs[1]) || 
	mxIsComplex(prhs[1])) {
	mexErrMsgIdAndTxt("MyToolbox:potential:notDouble","Input matrix must be type double.");
    }

    /* make sure the third input argument is type double */
    if( !mxIsDouble(prhs[2]) || 
	mxIsComplex(prhs[2])) {
	mexErrMsgIdAndTxt("MyToolbox:potential:notDouble","Input matrix must be type double.");
    }
    
    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[0])!=1) {
	mexErrMsgIdAndTxt("MyToolbox:potential:notRowVector","Input must be a row vector.");
    }

    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[1])!=1) {
	mexErrMsgIdAndTxt("MyToolbox:potential:notRowVector","Input must be a row vector.");
    }

    /* check that number of rows in second input argument is 1 */
    if(mxGetM(prhs[2])!=2) {
	mexErrMsgIdAndTxt("MyToolbox:potential:notRowVector","Input must be a row vector.");
    }
    
    /* get the value of the scalar input  */
    xMatrix = mxGetPr(prhs[0]);

    /* create a pointer to the real data in the input matrix  */
    yMatrix = mxGetPr(prhs[1]);

    /* get dimensions of the input matrix */
    sizeX = mxGetN(prhs[1]);

    chargeMatrix = mxGetPr(prhs[2]);

    chargeRows = mxGetM(prhs[2]);
    sizeCharge = chargeRows*mxGetN(prhs[2]);
    
    /* create the output matrix */
    plhs[0] = mxCreateDoubleMatrix((mwSize)sizeX, (mwSize)sizeX, mxREAL);

    d = mxGetScalar(prhs[3]);
    a = mxGetScalar(prhs[4]);
    /* get a pointer to the real data in the output matrix */
    outMatrix = mxGetPr(plhs[0]);

    /* call the computational routine */
    potential(a, d, xMatrix, yMatrix, chargeMatrix, outMatrix, sizeX, chargeRows, sizeCharge);
}
