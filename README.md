## Sources

The ground truth images for this model were selected from these historic books:

- Kiel city directory (1888)
- Frapan: Bittersüß (1891)
- Ludendorff: Kriegserinnerungen (1921)
- Menzel: Der praktische Maurer  (1847)
- Egger: Die christliche Mutter (1914)
- Ehrenbuch der Gefallenen Stuttgarts (1925)

In addition samples from this book are included for testing the robustness of the model:

- Chronik der nördlichen Probstei 

## Special characters

### I and J

A problem with Fraktur are the upper-case letters I and J. For many Fraktur fonts they are indistinguishable. For example, compare the I in Im and the J in Jäger:

![Im](images/I.png)

![Jäger](images/J.png)

However, for a neuronal network two indistinguishable but different characters are a big problem. Therefore, it might be better to decide on one letter to avoid the ambiguity. I suggest the uppercase I. As a consequence every J will be recognized as I. The result will be some strange words such as "Iuly". 

Using a language model you can easily replace the wrong characters. In German an uppercase J is usually followed by a lowercase vowel. 

### s, tz, ch, ck and others

Fraktur has a few special characters that usually do not occur in 'normal' text, such as the long-S or the tz ligature. This model (and the ground truth) translates them into 'normal' characters. Therefore a long-S will be interpreted as s and the ligatures will be interpreted as two characters.

![Wasser](images/long-s.png)

### Quotation mark

Often you will find two different kind of quotation marks. The opening lower quotation marks the closing upper quotation marks.

![„Bildhauer“](images/quot.png)

I decided to distinguish between the two kind of quotation marks. 

- opening: „
- closing: “

Therefore, the image above becomes „Bildhauer“.