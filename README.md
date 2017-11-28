# WebLogger Data Processing

## Introduction
Program of data pre-processing and feature extraction in WebLogger.

## File Structure
```Bash
├── stream                  # stream processing files
│   ├── main.m
│   ├── data_distribution_batch.m
│   └── ...
├── unit                    # unit test files
│   ├── unit_interp.m
│   ├── unit_main.m
│   └── ...
├── MFCC                    # custom MFCC function lib
│   ├── freq_to_mel.m       # frequency-scale to Mel-scale function
│   ├── mel_filter_bank.m   # Mel frequency filterbank
│   └── ...
├── .gitignore
├── LICENSE
└── README.md
```

# License

 [GPL-3.0 © wurahara](https://github.com/wurahara/weblogger-data-processing/blob/master/LICENSE)