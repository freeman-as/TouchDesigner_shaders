## 001_DisplacementMapping
Noise TOPで生成したノイズマップを元にジオメトリの頂点操作するシェーダー

---
### 使用したTouchDesignerのノードについて

- **Sphere (SOP)**
  Sphere geometryを生成

  http://ted-kanakubo.com/touchdesigner-jp/?p=255
  https://docs.derivative.ca/Sphere_SOP
  https://docs.derivative.ca/SphereSOP_Class

  ```C++
  [Note]
  // Rows / Columnsで頂点を増やす
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明                     |
  | ------------ | ------------------------ |
  | Rows         | Creates horizontal lines |
  | Columns      | Creates vertical lines   |



- **Transform (SOP)**
  geometryの頂点のxyz座標位置を変更

  http://ted-kanakubo.com/touchdesigner-jp/?p=246
  https://docs.derivative.ca/Transform_SOP
  https://docs.derivative.ca/TransformSOP_Class

  ```C++
  [Note]
  // 
  ```

  **[良く使うパラメーター]**

  | パラメーター  | 説明                                          |
  | ------------- | --------------------------------------------- |
  | Translate     | 各軸で移動                                    |
  | Rotate        | 各軸で回転                                    |
  | Scale         | 各軸で拡大                                    |
  | Uniform Scale | 3軸すべてに沿ってジオメトリを同時に拡大・縮小 |



- **Texture (SOP)**
  テクスチャおよびバンプマッピングで使用するために、テクスチャのUV座標とW座標をジオメトリに割り当てる。テクスチャー・コーディネートのマルチ・レイヤを作成

  http://ted-kanakubo.com/touchdesigner-jp/?p=250
  https://docs.derivative.ca/Texture_SOP
  https://docs.derivative.ca/TextureSOP_Class

  ```C++
  [Note]
  // 
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明 |
  | ------------ | ---- |
  | Texture Type |      |



- **Convert (SOP)**
  ジオメトリ・タイプを変換

  http://ted-kanakubo.com/touchdesigner-jp/?p=291
  https://docs.derivative.ca/Convert_SOP
  https://docs.derivative.ca/ConvertSOP_Class

  ```C++
  [Note]
  // 任意のジオメトリをパーティクルに変換する用途が多い
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明                         |
  | ------------ | ---------------------------- |
  | Convert To   | どのタイプに変換するかを設定 |



- **Point (SOP)**
  ポイントの位置、色、テクスチャ座標、法線、およびその他の属性を操作。 カスタムポイント属性を作成することも可能

  http://ted-kanakubo.com/touchdesigner-jp/?p=486
  https://docs.derivative.ca/Point_SOP
  https://docs.derivative.ca/PointSOP_Class

  ```C++
  [Note]
  // 
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明                         |
  | ------------ | ---------------------------- |
  | Convert To   | どのタイプに変換するかを設定 |



- **Noise (TOP)**
  ランダムなノイズ・パターンを生成。CPU上で動作してGPUにそのイメージをパスする

  http://ted-kanakubo.com/touchdesigner-jp/?p=486
  https://docs.derivative.ca/Noise_TOP
  https://docs.derivative.ca/NoiseTOP_Class

  ```C++
  [Note]
  // Translate tzの値にabsTime.secondsでノイズパターンを動的に生成
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明                                                     |
  | ------------ | -------------------------------------------------------- |
  | Type         | どのタイプに変換するかを設定                             |
  | Seed         | 数値によってジェネレータが生成するノイズパターンを変える |
  | Period       | ノイズ周期                                               |
  | Amplitude    | ノイズ値の振幅（値出力のスケール）を定義                 |
  | Offset       | ノイズパターンの中点の色を定義                           |
  | Monochrome   | カラーまたはモノクロのノイズを切り替え                   |
  | Translate    | 3Dノイズ空間の異なる部分をサンプリング                   |



- **Phong (MAT)**
  フォン・シェーディング・モデルを使用してマテリアルを作成

  http://ted-kanakubo.com/touchdesigner-jp/?p=82
  https://docs.derivative.ca/Phong_MAT
  https://docs.derivative.ca/PhongMAT_Class

  ```C++
  [Note]
  // 
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明 |
  | ------------ | ---- |
  |              |      |



- **GLSL (MAT)**
  TouchDesignerにカスタム・マテリアルを適用

  http://ted-kanakubo.com/touchdesigner-jp/?p=83
  https://docs.derivative.ca/GLSL_MAT
  https://docs.derivative.ca/GlslMAT_Class

  ```C++
  [Note]
  // 
  ```

  **[良く使うパラメーター]**

  | パラメーター | 説明 |
  | ------------ | ---- |
  |              |      |







------

### TDGLSLについて

https://docs.derivative.ca/Write_a_GLSL_TOP
https://www.derivative.ca/wiki088/index.php?title=Write_a_GLSL_Material

**TouchDesigner GLSL規約**

- 関数名は常に頭文字にはTD
- uniformの頭文字はuTD
- samplerの頭文字はsTD
- 頂点情報はSOPインターフェース内のものと同じ名前（P、N、Cd、uv）

**Vertex Shader**

- 頂点シェーダの中では、1つの頂点にしかアクセスできず、他の頂点の位置や、他の頂点に対する頂点シェーダの出力がどうなるかはわからない
- 頂点シェーダへの入力は、プログラムが実行されている特定の頂点に関するすべてのデータで、SOP空間の頂点位置、テクスチャ座標、色、法線などのデータが利用可能。これらの値は属性と呼ばれ、inキーワードを使用して頂点シェーダで宣言されている
- 頂点シェーダが出力する主なものは、頂点の位置（ワールド、カメラ、および投影マトリックスによって変換された後の）、色、およびテクスチャ座標。 outを使用して宣言された出力変数を使用して、他の値も出力可能。頂点シェーダからの出力は、頂点がその一部であるプリミティブのサーフェスにわたって線形に補間。たとえば、線上の1番目の頂点に0.2の値と2番目の頂点に0.4の値を出力した場合、これら2つの点の中間に描画されたピクセルは0.3の値となる。

**Pixel Shader**

- ピクセルシェーダへの入力は、頂点シェーダからのすべての出力、および定義されているすべてのユニフォームで、頂点シェーダからの出力は、頂点が作成したポリゴン全体にわたって線形補間されている。
- ピクセルシェーダは、ColorとDepthの2つを出力。色は、layout（location = 0）out vec4 whateverNameとして宣言された変数を介して出力。深度は、out float depthNameとして宣言された変数を介して出力。
- 変数には好きな名前を付けることが可能。色の値は必ず書き出す必要があり、深さは書き出す必要はない（実際には、絶対に必要でない限り、実際には最適です）。深さの値を書き出さなければ、GLSLは自動的に正しい深さの値を出力。マルチカラーバッファに出力する場合は、location値を0ではなく1、2、3などに設定して、より多くのカラー出力を宣言。

### 

------

### TouchDesginer GLSL API

- **``P (vec3)``**
  処理中の頂点の位置。ジオメトリの頂点座標

- **``N (vec3)``**
  法線情報

- **``Cd (vec4)``**
  カラー情報

- **``TDDeform()``**
  頂点をワールド座標に変換

- **``TDWorldToProj()``**
  ラスタライズのためにワールド空間から投影空間に変換

  ```C++
  // Simple Vertex Shader
  void main()
  {
  	gl_Position = TDWorldToProj(TDDeform(P));
  }
  ```

- 

------

### EXPRESSION

##### [Project Class]

https://docs.derivative.ca/Project_Class

- **``project.name [Read Only]``**
  toeファイル名を取得
- 

##### [OP Class]

https://docs.derivative.ca/OP_Class

- 

##### [td Module]

https://docs.derivative.ca/Td_Module

- **``me (OP) [Read Only]``**
  実行または評価されている現在の演算子への参照

- **``absTime.seconds (float) [Read Only]``**
  アプリケーションが起動してから再生された絶対合計秒数

  https://docs.derivative.ca/AbsTime_Class のMembers

- 

------

### ショートカット

#### [ノード関連]

- 

------

### メモ

- 