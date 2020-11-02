# CEG2722 Data Analysis 2

Part 2 of the module Data Analysis 2 : Introduction to Linux data processing.

## Lectures

[slides](http://koulali.github.io/CEG2722/#/)

## Labs

Login to your university unix server and run the following script:

```bash
wget https://raw.githubusercontent.com/koulali/CEG2722/main/startup/make_ceg2722.sh
chmod +x make_ceg2722.sh
./make_ceg2722.sh
```


The practical instructions are available:

[practical1](https://github.com/koulali/CEG2722/blob/main/practicals.md)


### Serving the slides


```
reveal-md slides.md --css style.css
```

to generate a static version
```
reveal-md slides.md --css style.css --static docs --static-dirs=img,pkg
```

Use make serve to start a server at http://localhost:8000. The page will automatically reload the page when you update any of the files in the repository.


## License

The slides were made using [reaveal-md](https://github.com/webpro/reveal-md) and the theme was inspired by [Leonardo Uieda's template](https://github.com/leouieda/talk-template).


