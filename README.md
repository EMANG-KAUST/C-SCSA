# Signal denoising based on SCSA and a curvature constraint (C-SCSA)

Matlab implementation of the C-SCSA method.

[![Paper1](https://img.shields.io/badge/paper-IET%20journal-brightgreen)](https://ietresearch.onlinelibrary.wiley.com/doi/10.1049/sil2.12023)
[![Paper2](https://img.shields.io/badge/paper-ArXiv-blueviolet)](https://arxiv.org/abs/1908.07758)
[![Discord](https://img.shields.io/badge/Code%20Coverage-70%25-yellowgreen)](https://github.com/EMANG-KAUST/C-SCSA/blob/main/README.md)

## Running the project code
The original source is developed in Matlab 2016. An equaling or higher version is recommended. Download the project to your local Matlab directory and include all folders and subfolders in the project.

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

For example, if we want to create a bumps signal (around 500 samples) with uniform noise (distrubuted between (0,10), use the following command:

```shell
y = load_signal('Piece-Regular', 500);
n = uniformNoise(length(y),10)';
signal=y+n;
```

