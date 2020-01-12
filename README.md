# Fraktur model for OCRopus

This is a character model for recognizing Fraktur font with [OCRopus](https://github.com/tmbdev/ocropy).

With test data that has not been used in the training process it yields an excellent error rate of 1.089%. The 'standard' Fraktur model shows an error rate of 3.14% for the same test data.

In addition to the pyrnn.gz model to be used with `ocropus-rpred` I have also trained a character model for [CLSTM](https://github.com/tmbdev/clstm).


## Sources

The ground truth images for this model were selected from these historic books:

- Topographische Chronik von Breslau  (1805)
- Menzel: Der praktische Maurer  (1847) urn:nbn:de:kobv:b4-25126-9
- Kiel city directory (1888)
- Köln city directory (1891)
- Gartenlaube Heft 1, S. 8 (1897)
- Munzinger: Die Japaner (1898) urn:nbn:de:kobv:b4-200905194219
- Frapan: Bittersüß (1891) urn:nbn:de:kobv:b4-200905191440
- Schiller und Oberösterreich (1905) urn:nbn:at:AT-OOeLB-1099695
- Kreis-Kalender für den Kreis Plön (1909) urn:nbn:de:gbv:8:2-2533517
- Das astronomische Weltbild im Wandel der Zeit (1912) urn:nbn:at:AT-OOeLB-4113427
- Egger: Die christliche Mutter (1914) urn:nbn:de:kobv:b4-30011-9
- Was sollen wir kochen? (1915)  urn:nbn:at:AT-OOeLB-1184253
- Der Große Krieg in Einzeldarstellungen - Die Winterschlacht in Masuren  (1918) urn:nbn:at:AT-OOeLB-1691328
- Preuschen: Yoshiwara (1920) urn:nbn:de:kobv:b4-30090-0
- Ludendorff: Kriegserinnerungen (1921)
- Ehrenbuch der Gefallenen Stuttgarts (1925)
- Zedlitz: Die Zedlitze und ihre Heimat (1925)

For some rare characters (Q, Y, Ä, Ö and Ü) I have generated some synthetic training data with OCRopus-linegen using the Walbaum Fraktur font and words from a German dictionary.

In addition, samples from these documents are included for testing the robustness of the model:

- Peters: Wisch und Umgegend (1898)
- Internationaler Funkentelegraphenvertrag (1906)
- Das Inselschiff, eine Zeitschrift für Freunde der Literatur und des schönen Buches, page 23 (1914)

## Special characters

### I and J

A problem with Fraktur are the upper-case letters I and J. For many Fraktur fonts they are indistinguishable. For example, compare the I in Im and the J in Jäger:

![Im](images/I.png)

![Jäger](images/J.png)

However, for a neuronal network two indistinguishable but different characters are a big problem. Therefore, it might be better to decide on one letter to avoid the ambiguity. I suggest the uppercase I. As a consequence every J will be recognized as I. The result will be some strange words such as "Iuly".

Using a language model you can easily replace the wrong characters. In German an uppercase J is usually followed by a lowercase vowel.

### s, tz, ch, ck and others

Fraktur has a few special characters that usually do not occur in 'normal' text, such as the long-S or the tz ligature. This model (and the ground truth) recognizes the correct Unicode character LATIN SMALL LETTER LONG S. The tz ligature is interpreted as two characters.

![Wasser](images/long-s.png)

### Quotation mark

Often you will find two different kinds of quotation marks, the opening lower quotation mark and the closing upper quotation mark.

![„Bildhauer“](images/quot.png)

I decided to distinguish between the two kinds of quotation marks.

- opening: „
- closing: “

Therefore, the image above becomes „Bildhauer“.

## Training
### ocropy
To train the model from scratch you can use this command:

	ocropus-rtrain -c codec.txt -F 2000 -o fraktur "training/*.bin.png"

(Make sure that the OCRopus directory is included in PATH.) If you want to improve the existing model you can start with it:

	ocropus-rtrain -c codec.txt -F 2000 --load fraktur.pyrnn.gz -o fraktur "training/*.bin.png"

You can see the training progress in this image:

![diagram showing the training progress](images/accuracy.png)

If you are interested in the amount of ground-truth data  and the character accuracy for each book used for the model traning, take a look at the `overview-*` diagrams in the `images` folder.
