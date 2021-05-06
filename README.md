# Signal denoising based on SCSA and a curvature constraint (C-SCSA)

Matlab implementation of the C-SCSA method.

[![Paper1](https://img.shields.io/badge/paper-IET%20journal-brightgreen)](https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/sil2.12023)
[![Paper2](https://img.shields.io/badge/paper-ArXiv-blueviolet)](https://arxiv.org/abs/1908.07758)
[![Discord](https://img.shields.io/badge/Code%20Coverage-70%25-yellowgreen)](https://github.com/EMANG-KAUST/C-SCSA/blob/main/README.md)

## Modules 

### Data generation
There are different types of signals you can generate, including:

|     Types     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :-----------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  **`Gaussian`**   | The Gaussian signal is recommended to be used in simulation, which [SCSA](https://link.springer.com/content/pdf/10.1007/s00498-012-0091-1.pdf) is good at characterizing. Signals such as [chromatography](https://en.wikipedia.org/wiki/Chromatography) spectral peaks can be modeled by Gaussian peaks generation function. The users will be able to change the amplitude(hgt), position(pos) and width(wdt) of peak `[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,0)` in favor of their options. Output of the function is yf0. To adjust output signal length, change `x = linspace(0,1,#{length});`in line 2 of Gaussian_signal_generation.m         |
|   `Regular`    | key='regular' or key='Piece-Regular'(options.alpha gives regularity). The users will be able to generate by `y = load_signal(key, signal_length, options)`.  |
|   `Bumps`    | key='Bumps'. The users will be able to generate by `y = load_signal(key, signal_length, options)`. |
|  `Sing`   | key='Sing'. The users will be able to generate by `y = load_signal(key, signal_length, options)`.                                                                                                                                                                                                                                                              |
|     `Noise(Gaussian)`     | Gaussian noise is statistical noise having a probability density function (PDF) equal to that of the normal distribution, which is also known as the Gaussian distribution. key='gaussiannoise' (options.sigma gives width of filtering in pixels). The users will be able to generate by `y = load_signal(key, signal_length, options)`.                                                                                                                                                                                                                                                                    |
|   `Noise(Uniform)`   | Uniform noise refers to random noise generated in the interval (0,level), user can also specify the number of noise samples by `[n] = uniformNoise(length,level)`).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

If we want to create a piece-wise regular signal (around 500 samples) with uniform noise (distrubuted between (0,10), use the following command:

```matlab
y_clean = load_signal('Piece-Regular', 500);
n = uniformNoise(length(y_clean),10)';
y_noisy=y_clean+n;
```
More specifically, if we are generating gaussian signals with uniform noise (level%), use the following command:

```matlab
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,level);
```

For example, let's say we want to generate a 4-peak gaussian signal, with 50% of noise, we can simply type:

```matlab
pos=[2,3.6,7,9];
hgt= [2,4,4.5,7];
wdt=[2,3,3,4];
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,50);
plotGenFig(yf,yf0);
```

The generated 4-peak signal will look like below:
![alt text](https://github.com/EMANG-KAUST/C-SCSA/blob/main/img/fig1.jpg)

### Signal denoising with C-SCSA
To perform SCSA utilities, use the following function with the specifications:
|     Utilities    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| :-----------: | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  **`C-SCSA`**   | Our main C-SCSA implementation. It is the entry point into the denoising algorithm, capable of taking any noisy signal as input (signals with 300-10000 samples are recommended for computing perspectives). To peform denoising, simply use `[ yscsa,mse,snr ,psnr] = SCSAden( yf,yf0,v )` **function Input**: `v` is a smoothness parameter related to eq. (11) in our [paper](https://ietresearch.onlinelibrary.wiley.com/doi/epdf/10.1049/sil2.12023). `yf` is the noisy signal and `yf0` is the clean signal, with possible values between (-5,5). `v` varies with input signal types, signal length and sampling frequencies.  **function Output**: `yscsa` is the denoised signal. `snr` and `mse` is the SNR and mean squared error (MSE) of the denoised signal for evaluation purposes. |
|   `Fast`    | C-SCSA fast version. We are currenlty using _fminsearch_ to speed up the searching process in eq. (10) in our [paper](https://ietresearch.onlinelibrary.wiley.com/doi/epdf/10.1049/sil2.12023), which uses the simplex search method of [Lagarias et al](https://www.researchgate.net/publication/216301003_Convergence_Properties_of_the_Nelder--Mead_Simplex_Method_in_Low_Dimensions). This version is currently in the research process and not available in the repository. |
|  `h_Select`   | Optimal `h` selection for denoising. This function is for testing purposes. Users will be able to extract the optimal `h` that bestly denoise a noisy signal `yf` by running:`[ de,h_optimal,snr ] = SCSA_H_Select( yf,yf0 )`. **function Input**: `v` is a smoothness parameter related to eq. (11) in our [paper](https://ietresearch.onlinelibrary.wiley.com/doi/epdf/10.1049/sil2.12023). `yf` is the noisy signal and `yf0` is the clean signal, with possible values between (-5,5). `v` varies with input signal types, signal length and sampling frequencies.  **function Output**: `yscsa` is the denoised signal. `snr` and `mse` is the SNR and mean squared error (MSE) of the denoised signal for evaluation purposes.                                                                                                                                                                                                                                                           |
|  `Assembly`   | Denoise signal by separating whole signal into regions of interest and apply C-SCSA on each. This module is currently in its testing stages and is not available in the repository.                                                                                                                                                                                                                                                          |
|   `SCSA`    | SCSA reconstruction. Users can decompose the signal with a positive `h` value, by `[yscsa,Nh,EigV,EigF] = scsa_build(h,y)`. **function Input**: `h` is a positive value, also known as the [SCSA](https://link.springer.com/content/pdf/10.1007/s00498-012-0091-1.pdf) semi-classical constant. It can be selected by [Quantum-based interval selection](https://ieeexplore.ieee.org/abstract/document/9287878). `y` is the input signal to be decomposed.  **function Output**: `yscsa` is the decomposed signal, `Nh` is the number of eigenfunctions. `EigV` is a matrix with eigenvalues on its diagonal (you can export the eigenvalues by `diag(EigV)`. `EigF` is the matrix of eigenfunctions. [UI interface](https://github.com/EMANG-KAUST/SCSA-reconstruction) of this tool is also available.  |


### Run a Demo (A quick start)
```matlab
pos=[2,3.6,7,9]
hgt= [2,4,4.5,7]
wdt=[2,3,3,4]
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,50)
plotGenFig(yf,yf0)
}
```
## About the project code
The original source is developed in Matlab 2016a. An equaling or higher version is recommended. Download the project to your local Matlab directory and include all folders and subfolders in the project.

### License

The C-SCSA library (i.e. all code inside of the `functions` directory) is licensed under the
[GNU General Public License v3.0](https://www.gnu.org/licenses/gpl-3.0.en.html), also
included in our repository in the `COPYING` file.
