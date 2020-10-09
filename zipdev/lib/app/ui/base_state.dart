import 'package:flutter/material.dart';
import 'package:zipdev/app/blocs/provider/bloc.dart';
import 'package:zipdev/app/blocs/provider/provider.dart';
import 'package:zipdev/app/context/settings/app_localizations.dart';

abstract class BaseState<T extends StatefulWidget,K extends Bloc> extends State<T>{
  AppLocalizations l10n;
  K bloc;

  @override
  void initState() {
    super.initState();
    bloc = Provider.of<K>(getBlocInstance);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    l10n = AppLocalizations.of(context);//To multi language support
  }

  @override
  void dispose() {
    Provider.dispose<K>();
    super.dispose();
  }

  K getBlocInstance();
}