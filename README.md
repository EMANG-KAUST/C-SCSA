# Signal denoising based on SCSA and a curvature constraint (C-SCSA)

Matlab implementation of the C-SCSA method.

[![Paper1](https://img.shields.io/badge/paper-IET%20journal-brightgreen)](https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/sil2.12023)
[![Paper2](https://img.shields.io/badge/paper-ArXiv-blueviolet)](https://arxiv.org/abs/1908.07758)
[![Discord](https://img.shields.io/badge/Code%20Coverage-70%25-yellowgreen)](https://github.com/EMANG-KAUST/C-SCSA/blob/main/README.md)

## Running the project code
The original source is developed in Matlab 2016a. An equaling or higher version is recommended. Download the project to your local Matlab directory and include all folders and subfolders in the project.

### Signal and noise generation
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

```shell
y_clean = load_signal('Piece-Regular', 500)
n = uniformNoise(length(y_clean),10)'
y_noisy=y_clean+n
```
More specifically, if we are generating gaussian signals with uniform noise (level%), use the following command:

```shell
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,level)
```

For example, let's say we want to generate a 4-peak gaussian signal, with 50% of noise, we can simply type:

```shell
pos=[2,3.6,7,9]
hgt= [2,4,4.5,7]
wdt=[2,3,3,4]
[f, yf, yf0]=Gaussian_signal_generation(pos,hgt,wdt,50)
```

The generated 4-peak signal will look like below:
![alt text](https://github.com/EMANG-KAUST/C-SCSA/blob/main/img/fig1.jpg)

### Signal denoising with C-SCSA
To perform SCSA, use the following function with the specifications.

**function Input**: `v` is a smoothness parameter related to eq. (11) in our [IET paper](https://ietresearch.onlinelibrary.wiley.com/doi/epdf/10.1049/sil2.12023). `yf` is the noisy signal and `yf0` is the clean signal, with possible values between (-5,5).

**function Output**: `yscsa` is the denoised signal. `snr` and `mse` is the SNR and mean squared error (MSE) of the denoised signal for evaluation purposes.

```shell
[ yscsa,mse,snr ,psnr] = SCSAden( yf,yf0,v )
```

### Run a Demo
