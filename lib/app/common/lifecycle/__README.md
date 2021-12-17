## ANIMATION WIDGET

## Use example:

### TransalateAnimation

// untuk animasi widget dari arah atas ke bawah dan sebaliknya dan dari arah kanan ke kiri atau sebaliknya

```
TranslateAnimation(
    offset: 40, // jarak dari posisi yang diinginkan, set jadi negatif jika ingin arah berlawanan
    curve: Curves.fastOutSlowIn, // set curve animation
    offsetDirection: Axis.vertical, // set arah .. vertikal untuk atas ke bawah dan sebaliknya, horizontal untuk kanan ke kiri dan sebaliknya
    duration: Duration(milliseconds: duration), // set duration
    child: Container(
        .... // widget yang ingin diberikan animation
    )
)

```

### OpacityAnimation

// untuk animasi widget yang kelihatan menjadi transparant dan sebaliknya

```
OpacityAnimation(
    begin: 0, // nilai opacity awal widget
    end: 0, // nilai opacity akhir widget
    curve: Curves.fastOutSlowIn, // set curve animation
    duration: Duration(milliseconds: duration), // set duration
    child: Container(
        .... // widget yang ingin diberikan animation
    )
)
```

### ScaleAnimation

// untuk animasi widget kecil ke besar dan sebaliknya

```
ScaleAnimation(
    initScale: 0, // nilai ukuran awal widget
    finalScale: 0, // nilai ukuran akhir widget
    curve: Curves.fastOutSlowIn, // set curve animation
    duration: Duration(milliseconds: duration), // set duration
    child: Container(
        .... // widget yang ingin diberikan animation
    )
)
```



