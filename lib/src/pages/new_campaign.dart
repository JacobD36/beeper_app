import 'package:flutter/material.dart';
import 'package:beeper_app/src/models/campaign_model.dart';
import 'package:beeper_app/src/providers/app_provider.dart';
import 'package:beeper_app/src/services/campaign_service.dart';
import 'package:beeper_app/src/bloc/campaign/new_campaign_bloc.dart';
import 'package:beeper_app/src/global/environment.dart';
import 'package:beeper_app/src/utils/back_design.dart';
import 'package:beeper_app/src/widgets/menu.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class NewCampaign extends StatefulWidget {
  static final String routeName = 'new_campaign';

  @override
  _NewCampaignState createState() => _NewCampaignState();
}

class _NewCampaignState extends State<NewCampaign> {
  final TextEditingController _controller = new TextEditingController();
  final campaignProvider = new CampaignService();
  String _fecha = '';

  @override
  Widget build(BuildContext context) {
    final newCampaignBloc = AppProvider.newCampaignBloc(context);

    return Scaffold(
      key: Environment.scaffoldKey,
      appBar: AppBar(
        title: Text('Nueva Campaña'),
      ),
      drawer: Drawer(
        child: MenuWidget()
      ),
      body: ModalProgressHUD(
        inAsyncCall: newCampaignBloc.isLoading, 
        child: Stack(
          children: [
            BackDesign(),
            _formData(context, newCampaignBloc)
          ]
        )
      )
    );
  }

  Widget _formData(BuildContext context, NewCampaignBloc bloc) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        color: Color.fromRGBO(62, 66, 107, 0.7)
      ),
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0
        ),
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text('Ingrese la información básica de la campaña a registrar', style: TextStyle(color: Colors.white, fontSize: 15.0)),
          ),
          SizedBox(height: 20.0),
          _titleInput(bloc),
          SizedBox(height: 10.0),
          _descInput(bloc),
          SizedBox(height: 10.0),
          _responsableInput(context, bloc),
          SizedBox(height: 10.0),
          _phoneInput(context, bloc),
          SizedBox(height: 20.0),
          Divider(color: Colors.white70),
          SizedBox(height: 10.0),
          _buttonList(context, bloc)
        ],
      ),
    );
  }

  Widget _titleInput(NewCampaignBloc bloc) {
    return StreamBuilder(
      stream: bloc.nameStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: _controller,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0)
            ),
            hintText: 'Nombre de la campaña',
            hintStyle: TextStyle(color: Colors.white38),
            labelText: 'Nombre',
            icon: Icon(Icons.ballot, color: Colors.white),
            labelStyle: new TextStyle(
              color: Colors.white
            ),
            //errorText: snapshot.error
          ),
          style: TextStyle(color: Colors.white),
          onChanged: bloc.changeName,
          validator: (value) {
            if(value != null && value.length >= 3) {
              return null;
            }
            return snapshot.error;
          },
        );
      }
    );
  }

  Widget _descInput(NewCampaignBloc bloc) {
    return StreamBuilder(
      stream: bloc.descStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLines: 3,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Descripción de la campaña',
            hintStyle: TextStyle(color: Colors.white38),
            labelText: 'Descripción',
            icon: Icon(Icons.speaker_notes, color: Colors.white),
            labelStyle: new TextStyle(
              color: Colors.white
            ),
            //errorText: snapshot.error
          ),
          style: TextStyle(color: Colors.white),
          onChanged: bloc.changeDesc,
          validator: (value) {
            if(value != null && value.length >= 20) {
              return null;
            }
            return snapshot.error;
          },
        );
      }
    );
  }

  Widget _responsableInput(BuildContext context, NewCampaignBloc bloc) {
    return StreamBuilder(
      stream: bloc.responsableStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return 
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Persona responsable de la campaña',
            hintStyle: TextStyle(color: Colors.white38),
            labelText: 'Nombre del responsable',
            icon: Icon(Icons.account_circle, color: Colors.white),
            labelStyle: new TextStyle(
              color: Colors.white
            ),
            //errorText: snapshot.error
          ),
          style: TextStyle(color: Colors.white),
          onChanged: bloc.changeResponsable,
          validator: (value) {
            if(value != null && value.length >= 3) {
              return null;
            }
            return snapshot.error;
          },
        );
      }
    );
  }

  Widget _phoneInput(BuildContext context, NewCampaignBloc bloc) {
    return StreamBuilder(
      stream: bloc.phoneStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enableInteractiveSelection: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0)
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(20.0),
            ),
            hintText: 'Teléfono del responsable',
            hintStyle: TextStyle(color: Colors.white38),
            labelText: 'Teléfono',
            icon: Icon(Icons.phone, color: Colors.white),
            labelStyle: new TextStyle(
              color: Colors.white
            ),
            //errorText: snapshot.error
          ),
          style: TextStyle(color: Colors.white),
          onChanged: bloc.changePhone,
          validator: (value) {
            if(value != null && value.length >= 8) {
              return null;
            }
            return snapshot.error;
          },
        );
      }
    );
  }

  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      locale: Locale('es','ES'),
      context: context, 
      initialDate: new DateTime.now(), 
      firstDate: new DateTime(2018), 
      lastDate: new DateTime(2025)
    );

    if (picked != null) {
      setState(() {
        _fecha = picked.day.toString() + '/' + picked.month.toString() + '/' + picked.year.toString();
      });
    }
  }

   _saveCampaign(Campaign camp, NewCampaignBloc bloc) async {
    setState(() {
      bloc.isLoading = true;
    });

    await this.campaignProvider.saveCampaign(camp);

    setState(() {
      bloc.isLoading = false;
    });
  }

  Widget _buttonList(BuildContext context, NewCampaignBloc bloc) {
    final Campaign campData = new Campaign();

    return Container(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: bloc.formValidStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ElevatedButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    child: Text('Grabar'),
                  ),
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: snapshot.hasData? MaterialStateProperty.all(Colors.blue[600]) : MaterialStateProperty.all(Colors.grey[600]),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
                  ),
                  onPressed: snapshot.hasData? () {
                    campData.title = bloc.name;
                    campData.desc = bloc.desc;
                    campData.responsable = bloc.resp;
                    campData.phone = bloc.phone;
                    _saveCampaign(campData, bloc);
                    bloc.changeName('');
                    bloc.changeDesc('');
                    bloc.changeResponsable('');
                    bloc.changePhone('');
                    _controller.clear();
                    Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'campaign');
                    //Navigator.of(context).pop();
                  } : null
                );
              }
            ),
            SizedBox(width: 10.0),
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                child: Text('Cancelar'),
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.red[400]),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)))
              ),
              onPressed: () {
                bloc.changeName('');
                bloc.changeDesc('');
                bloc.changeResponsable('');
                bloc.changePhone('');
                _controller.clear();
                //Navigator.pushReplacementNamed(Environment.scaffoldKey.currentContext, 'campaign');
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      ),
    );
  }
}