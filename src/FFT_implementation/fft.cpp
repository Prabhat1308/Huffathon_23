#include <bits/stdc++.h>
using namespace std;

const double PI = 3.141592653589793238460;

typedef std::complex<double> Complex;
typedef std::valarray<Complex> CArray;

using cd = complex<double>;

void fft(CArray &x)
{
    // DFT
    unsigned int N = x.size(), k = N, n;
    cout << N << endl;
    double thetaT = 3.14159265358979323846264338328L / N;   
    Complex phiT = Complex(cos(thetaT), -sin(thetaT)), T;
    while (k > 1)
    {
        n = k;
        k >>= 1;
        phiT = phiT * phiT;
        T = 1.0L;   
        for (unsigned int l = 0; l < k; l++)
        {
            for (unsigned int a = l; a < N; a += n)
            {
                unsigned int b = a + k;
                Complex t = x[a] - x[b];
                x[a] += x[b];
                x[b] = t * T;
            }
            T *= phiT;
        }
    }

    unsigned int m = (unsigned int)log2(N);
    for (unsigned int a = 0; a < N; a++)
    {
        unsigned int b = a;
        // Reverse bits
        b = (((b & 0xaaaaaaaa) >> 1) | ((b & 0x55555555) << 1));
        b = (((b & 0xcccccccc) >> 2) | ((b & 0x33333333) << 2));
        b = (((b & 0xf0f0f0f0) >> 4) | ((b & 0x0f0f0f0f) << 4));
        b = (((b & 0xff00ff00) >> 8) | ((b & 0x00ff00ff) << 8));
        b = ((b >> 16) | (b << 16)) >> (32 - m);
        if (b > a)
        {
            Complex t = x[a];
            x[a] = x[b];
            x[b] = t;
        }
    }
}

int main()
{
    // const Complex a[] = {cd(0, 0), cd(1, 1), cd(3, 3), cd(4, 4), cd(4, 4), cd(3, 3), cd(1, 1), cd(0, 0)};
    const Complex a[] = {cd(1,0),cd(-1,0),cd(0,1),cd(0,-1)};
    // const Complex a[] = {cd(1,0),cd(-1,0),cd(0,1),cd(0,-1),cd(1,0),cd(2,1),cd(3,3),cd(2,0)};
    CArray x(a, 4);
    fft(x);
    for (auto it : x)
    {
        cout << it << " ";
    }
    cout << endl;
}