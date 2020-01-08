# Aging Experiment
# Summary:
整個實驗分為2個目錄，分別是hspice_experiment和 multicore_experiment。有關hspice的實驗都在hspice_experiment目錄中，而有關multicore_experiment的實驗都在multicore_experiment目錄中。首先我們先介紹如何做hspice相關的實驗。
![](https://github.com/type59ty/aging-experiment/blob/master/figures/1.png)

## Hspice實驗步驟:
第一步先進入hspice_experiment目錄中
``
cd hspice_experiment
``
看到的檔案如下圖所示，我們會分別做介紹
![](https://github.com/type59ty/aging-experiment/blob/master/figures/2.png)
- benchmark目錄中是放isca85跟itc99的電路檔案，包含.v檔和.sp檔
- input_pattern目錄是放要餵進各個電路的input pattern，每組input pattern set相當於一個task
- ncverilog目錄是利用ncverilog來產生電路在各個input pattern set所對應的output pattern set。目的是最後用來驗證hspice的模擬結果(.sp)是否跟ncverilog的結果(.v)一致
- customized_32nm_model_card 目錄中是放NMOS的model card檔 (hspice會用到)
- model_card 目錄是存放不同老化時間點PMOS的model card檔 (hspice會用到)
- hspice_result 目錄是存放各個電路經過hspice模擬後的結果，包含delay跟power等資訊
- test_header 目錄是存放所有不同參數(i.e.不同老化時間, 不同電壓)的spice檔
- 其他的檔案就屬於執行實驗會用到的腳本(.pl)以及過程中產生的log檔
---
接下來我們來一步一步的執行hspice相關的實驗。hspice相關的實驗分為4個步驟，依序為:

1. 隨機產生電路的input pattern set
2. 使用ncverilog根據input pattern set來模擬出電路對應的output pattern set，此步驟的目的是最後用來驗證hspice的模擬結果是否跟ncverilog的結果一致
3. 產生出所有不同條件下(i.e. 不同老化時間, 不同電壓)的spice檔
4. 將第3的步驟所產生的spice用hspice模擬，得出電路在不同老化時間，不同電壓下的delay以及power資訊。

---
首先步驟一為隨機產生電路的input pattern set。
我們執行目錄下的gen_input_pattern.pl

``
./gen_input_pattern.pl c17 10 31
``

- 第一個參數c17是電路的名稱，可以自行更換 (i.e., c432, c499, c1908, ...)
- 第二個參數10是要隨機產生出幾組input pattern set
- 第三個參數31是一組input pattern set中有幾個input pattern

步驟一最後所隨機產生出的電路input pattern會存放在input pattern目錄中。
![](https://github.com/type59ty/aging-experiment/blob/master/figures/3.png)
每一個編號的.out檔都對應到一組input pattern set。下一個步驟我們要產生input pattern set所對應的output pattern set。

---

步驟二為透過ncverilog根據input pattern來模擬出電路的output pattern。我們首先移動到ncverilog的目錄中，在這個目錄下的檔案我們一樣會分別做說明。
``
cd ncverilog
``

![](https://github.com/type59ty/aging-experiment/blob/master/figures/4.png)

- INCA_libs目錄中存放執行ncverilog後所自動產生的檔案，並不重要
- isca85_v目錄存放isca85電路的.v檔，供ncverilog模擬
- 其他為執行ncverilog所用到的腳本以及產生出的log檔案

接下來說明如何使用ncverilog依據input pattern模擬出電路相對應的output pattern。我們執行run_ncverilog.pl這個腳本，command如下
<font color=red>註: 在下command前必須將server的shell換成tcsh，並確定有載入ncverilog</font>
``
./run_ncverilog.pl c17 10
``

- 第一個參數c17是要模擬的電路，可以自行替換(i.e., c432, c499, ...)
- 第二個參數10為步驟一所產生出的input pattern set總數

當腳本成功執行完畢之後，我們回到input pattern的資料夾中
``
cd ../input_pattern
``
我們會發現input pattern的目錄中多了output pattern相關的檔案，這些檔案是最後拿來驗證hspice的模擬結果是否跟ncverilog模擬的結果一致
![](https://github.com/type59ty/aging-experiment/blob/master/figures/5.png)

---

我們要在這個步驟三中產生出電路在所有不同條件下(i.e 不同老化時間, 不同電壓)之下的spice檔，才能在下一個步驟做hspice的模擬。我們回到hspice_experiment的目錄下，並執行run_input_profile.pl腳本

``
./run_input_profile.pl c17 31 10
``

- 第一個參數c17為電路名稱，可自行更換 (i.e., c432, c499, ...)
- 第二個參數31為每一組input pattern set中有幾個input pattern
- 第三個參數10為共有幾組input pattern set

成功執行完腳本後，我們移動到test_header目錄中
``
cd test_header
``
會在這個目錄下看到已經產生出電路在所有不同條件下所對應的spice檔案 (因為檔案非常多，因此只顯示出部分檔案)

![](https://github.com/type59ty/aging-experiment/blob/master/figures/6.png)

---

最後我們在步驟四中用hspice來模擬電路在所有不同條件下delay以及power的變化，我們先回到hspice_experiment目錄。
``
cd ..
``
在hspice_experiment目錄下執行run_hispice.pl這個腳本。
<font color=red>註: 在執行command前必須將server的shell換成tcsh，並確定有載入hspice</font>
``
./run_hspice.pl c17 Normal |& tee run_hspice_new.log
``

- 第一個參數c17為電路名稱，可自行更換 (i.e., c432, c499, ...)
- 第二個參數Normal為執行這個腳本的模式，模式分為Normal跟Search
- 而後面|& tee run_hspice_new.log只是要將過程都記錄在run_hspice_new.log檔而已

在正常情況下，我們只需要使用Normal模式就好。但是hspice常常執行失敗或是當掉卡死，導致腳本沒辦法順利地繼續執行下去，因此我們需要Search模式來找出hspice在哪裡執行失敗或是在那裡當掉卡住之後，再從中斷點繼續執行下去。

如果hspice在過程中不幸執行失敗或當掉卡死，我們就先打開這個run_hspice_new.log檔案
![](https://github.com/type59ty/aging-experiment/blob/master/figures/7.png)

正常來說如果hspice成功執行某一個case後，會出現以下提示

``
info:     ****** hspice job concluded
``

但如果執行失敗會產生error提示，當掉卡死則沒有任何提示。因此我們要做的是搜尋這個文件，將有error或沒有任何提示的那一個case全部都砍掉，然後將剩下所有hspice job concluded的內容複製到目錄下的run_hspice.log檔案中，提供Search模式來搜尋hspice已經模擬成功過的case。

<font color=red>再次強調!!! 如果run_hspice_new.log中有標示error的地方或沒有任何提示，代表hspice模擬失敗或是卡死，千萬不要複製到run_hspice.log中，以免Search模式會認為這個case是有成功模擬完的。</font>

最後經過hspice模擬後的相關result都會產生在hspice_result目錄下。

---

## Multicore實驗步驟:

有了每個電路在所有不同條件下的delay和power資訊，我們就能來模擬multicore的lifetime以及energy，首先我們先進到multicore_experiment的目錄
``
cd multicore_experiment
``

在目錄下會看到
![](https://github.com/type59ty/aging-experiment/blob/master/figures/8.png)

- benchmark_profile 目錄存放電路在所有不同條件下的delay以及power資訊 (lookup table)
- result 目錄存放最後multicore模擬出來原始的lifetime以及energy consumption資訊
- final_result目錄存放整理過後的數據，方便觀察
- source_code 目錄存放multicore實驗的程式碼
- object_code 目錄存放source code編譯成的object code
- env 這個檔案紀錄著task graph中所有critical task的組合
- task_graph就是描述task_graph的檔案
- Makefile就是編譯source code會用到的makefile
- main經過makefile編譯後程式的可執行檔
- run_simulate.pl執行multicore實驗的腳本
- simulate_parameter.pl這個腳本為run_simulate.pl在執行時會用到的參數腳本(不需要執行這個，因為run_simulate會自動呼叫)

首先我們打開run_simulate.pl這個腳本

![](https://github.com/type59ty/aging-experiment/blob/master/figures/9.png)

因為程式已經都自動化，所以我們只需要更改要模擬的電路，以及要模擬的policy就好。腳本中的第3行(line 3)是要模擬的電路，你可以任意增加要模擬的電路，例如改成下圖

![](https://github.com/type59ty/aging-experiment/blob/master/figures/10.png)

腳本中的第5到20行(line 5-20)是要模擬的policy。而在第4行(line 4)有每個policy所對應的編號，如果不要模擬某一個policy，我們只需要將迴圈中對應的policy註解掉就好。例如我們只想要模擬ROAD這個policy，那就將其他的都註解掉，如下圖。

![](https://github.com/type59ty/aging-experiment/blob/master/figures/11.png)

確認沒問題後，模擬時只需要執行以下這個command即可

``
./run_simulate.pl
``

最後multicore的lifetime和energy模擬結果會放在result目錄中

![](https://github.com/type59ty/aging-experiment/blob/master/figures/12.png)

我們隨便打開某一個結果的log檔，可以看到總共有3個column

![](https://github.com/type59ty/aging-experiment/blob/master/figures/13.png)

第一和第二個column為lifetime，差別只是年(year)跟秒(s)的單位不同而已。而第三個column為energy consumption，單位為瓦(watt)。

由於數據非常多，因此不可能透過人工的方式去一個個打開來整理。為了方便看數據，我們透過腳本來自動化整理數據，我們先到final_result的目錄下

![](https://github.com/type59ty/aging-experiment/blob/master/figures/14.png)

執行run_final_result.pl這個腳本就會幫我們整理出最後的數據(final_result.csv)
``
./run_final_result.pl
``
![](https://github.com/type59ty/aging-experiment/blob/master/figures/15.png)

