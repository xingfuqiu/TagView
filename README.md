### 基于 UICollectionView 实现的标签列表

为满足日前正在做的公司项目，所以造了这个轮子，暂时只满足了项目所用，定制化的东西比较多，后面会抽空做得通用一些。欢迎PR

效果图如下：
![preview.png]()

轮子特性：

* 可设置是否显示添加按钮
* 通过 `delegate` 来实现点击事件，暂时没有加 `block`
* 可定义4种显示类型
> 文字
> 图片+文字
> 文字+关闭
> 图片+文字+关闭

标签对齐用的是 [AlignedCollectionViewFlowLayout](https://github.com/mischa-hildebrand/AlignedCollectionViewFlowLayout) 就没有自己写了。
