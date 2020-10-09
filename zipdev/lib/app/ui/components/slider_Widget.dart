
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class SliderWidget extends StatelessWidget {

  final List<Widget> slides;
  final Color primaryColor;
  final Color secundaryColor;
  final bool dotsOnTop;
  final double primarySize;
  final double secundarySize;
  final EdgeInsetsGeometry dotsMargin;
  final EdgeInsetsGeometry pagePadding;
  // final Widget leadingButton;
  // final Widget trailingButton;

  SliderWidget({
    @required this.slides,
    this.secundaryColor,
    this.primaryColor,
    this.dotsOnTop = false,
    this.primarySize,
    this.secundarySize,
    this.dotsMargin,
    this.pagePadding
    // this.leadingButton,
    // this.trailingButton,
  });
  @override
  Widget build(BuildContext context) {

   
    return ChangeNotifierProvider(
      create: (c) => new SliderWidgetModel(),
          child: Builder(
            builder: (BuildContext context){

              if(this.primaryColor != null)Provider.of<SliderWidgetModel>(context).primaryColor = this.primaryColor;
              if(this.secundaryColor != null)Provider.of<SliderWidgetModel>(context).secundaryColor = this.secundaryColor;
              
              if(this.primarySize != null)Provider.of<SliderWidgetModel>(context).primarySize = this.primarySize;
              if(this.secundarySize != null)Provider.of<SliderWidgetModel>(context).secundarySize = this.secundarySize;

              return Stack(
                children: <Widget>[
                  _Slides(slides: this.slides,pagePadding: this.pagePadding,),
                  Column(
                    mainAxisAlignment: (this.dotsOnTop)?MainAxisAlignment.start:MainAxisAlignment.end,
                    children: <Widget>[
                      _Dots(pages: this.slides.length,dotsMargin: this.dotsMargin,)
                    ],
                  ),
                ],
              );
            },
          )
    );
  }

}

class _Slides extends StatefulWidget {

  final List<Widget> slides;
  final EdgeInsetsGeometry pagePadding;
  
  
  _Slides({
    @required this.slides,
    this.pagePadding
  });

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {

  final pageViewController = new PageController();

  int page;

  

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

     
    return Container(
      child: PageView(
        controller: pageViewController,
        onPageChanged: (index){
          Provider.of<SliderWidgetModel>(context,listen: false).currentPage = index;
        },
        children: widget.slides.map((slide)=>_Slide(slide:slide,pagePadding: widget.pagePadding,)).toList(),
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Widget slide;
  final EdgeInsetsGeometry pagePadding;

  _Slide({@required this.slide,this.pagePadding});

  @override
  Widget build(BuildContext context) {

    return  Container(
      padding: (this.pagePadding!=null)?this.pagePadding:EdgeInsets.symmetric(vertical: 50.0),
      width: double.infinity,
      height: double.infinity,
      child: this.slide,
    );
  }
}

class _Dots extends StatelessWidget {

  final pages;
  final EdgeInsetsGeometry dotsMargin;

  _Dots({@required this.pages,this.dotsMargin});


  @override
  Widget build(BuildContext context) {

    
    return Container(
      margin: (this.dotsMargin!=null)?this.dotsMargin:EdgeInsets.all(10.0),
      width: double.infinity,
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pages, (i)=>_Dot(dotId:i)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {

  final dotId;

  _Dot({@required this.dotId});

  @override
  Widget build(BuildContext context) {
    final sliderModel = Provider.of<SliderWidgetModel>(context);

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.all(5.0),
      width: (sliderModel.currentPage == dotId)?sliderModel.primarySize:sliderModel.secundarySize,
      height: (sliderModel.currentPage == dotId)?sliderModel.primarySize:sliderModel.secundarySize,
      decoration: BoxDecoration(
        color: (sliderModel.currentPage == dotId)? sliderModel.primaryColor:sliderModel.secundaryColor,
        shape: BoxShape.circle
      ),
    );
  }
}


class SliderWidgetModel extends ChangeNotifier {

  int _currentpage = 0;
  double _primarySize = 20.0;
  double _secundarySize = 15.0;
  Color _primaryColor = Colors.lightBlue;
  Color _secundaryColor = Colors.white;

  int get currentPage => this._currentpage;

  set currentPage(int currentPage){
    this._currentpage = currentPage;
    notifyListeners();
  }

  double get primarySize => this._primarySize;

  set primarySize(double primarySize){
    this._primarySize = primarySize;
  }

  double get secundarySize => this._secundarySize;

  set secundarySize(double secundarySize){
    this._secundarySize = secundarySize;
  }

  Color get primaryColor => this._primaryColor;

  set primaryColor(Color primaryColor){
    this._primaryColor = primaryColor;
  }

  Color get secundaryColor => this._secundaryColor;

  set secundaryColor(Color secundaryColor){
    this._secundaryColor = secundaryColor;
  }
}