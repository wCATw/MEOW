class GVAR(RscDisplayInsertMarker)
{
	enableSimulation=0;
	onLoad=QUOTE(_this call FUNC(onLoad));
	onUnload=QUOTE(call FUNC(unLoad));
	idd=IDD_DISPLAY_INSERT_MARKER;
	movingEnable=QUOTE(true);
	onKeyDown=QUOTE(_this call FUNC(DOWN));
	onKeyUp=QUOTE(_this call FUNC(UP));
	onMouseButtonDown=QUOTE(_this call FUNC(dClPic));
	onMouseZChanged=QUOTE(_this call FUNC(mouseZ));
	class controlsBackground
	{
		class Description: RscStructuredText
		{
			colorBackground[]=
			{
				32/255,
				18/255,
				5/255,
				0.85000002
			};
			idc=IDC_BACKGROUND_DESCRIPTION;
			x=0;
			y=0;
			w=QUOTE(10 * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(2 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
		};
	};
	class controls
	{
		class GVAR(Text): RscEdit
		{
			idc=IDC_TEXT;
			x=0;
			y=0;
			w=QUOTE(10 * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onKeyDown=QUOTE(_this call FUNC(editDOWN));
			colorBackground[]={0,0,0,0.80000001};
		};
		class GVAR(Picture): RscPicture
		{
			idc=IDC_PICTURE;
			moving=QUOTE(true);
			x=0.25998399;
			y=0.40000001;
			w=0.050000001;
			h=0.0666667;
		};
		class ButtonMenuOK: RscButtonMenuOK
		{
			default=1;
			idc=IDC_BUTTON_MENU_OK;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2('mark',[(ctrlParent (_this select 0))])] call FUNC(sendMark); true);
		};
		class ButtonChannel: GVAR(RscButton)
		{
			idc=IDC_BUTTON_CHANNEL;
			x=0;
			y=0;
			w=QUOTE(7 * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE(_this call FUNC(clickChann));
		};
		class ButtonMenuCancel: RscButtonMenuCancel
		{
			idc=IDC_MENU_CANCEL;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
		};
		class ButtonMenuInfo: GVAR(RscButtonMenu)
		{
			idc=IDC_MENU_INFO;
			text=QUOTE($STR_A3_RscDisplayInsertMarker_ButtonMenuInfo);
			x=0;
			y=0;
			w=QUOTE(10 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE((_this select 0) call FUNC(infoAnim));
		};
		class Settings_butt: GVAR(RscActivePicture)
		{
			idc=IDC_SETTINGS_BUTTON;
			text=QUOTE(\a3\Ui_f\data\GUI\Rsc\RscDisplayArcadeMap\icon_config_ca.paa);
			x=0;
			y=0;
			w=QUOTE(0.75 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE(_this spawn FUNC(setButt));
		};
		class add_group: GVAR(MDL_RscButton)
		{
			idc=IDC_ADD_GROUP;
			text=CSTRING(MDL_G);
			font=QUOTE(EtelkaNarrowMediumPro);
			colorBackgroundActive[]={0,0,0,0.89999998};
			x=0;
			y=0;
			w=QUOTE(0.73 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			h=QUOTE(1 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			sizeEx=QUOTE(0.8 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,'G')] call FUNC(fastText));
		};
		class add_name: GVAR(MDL_RscButton)
		{
			idc=IDC_ADD_NAME;
			text=CSTRING(MDL_N);
			colorBackgroundActive[]={0,0,0,0.89999998};
			font=QUOTE(EtelkaNarrowMediumPro);
			x=0;
			y=0;
			w=QUOTE(0.73 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			h=QUOTE(1 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			sizeEx=QUOTE(0.8 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,'N')] call FUNC(fastText));
		};
		class add_text: GVAR(MDL_RscButton)
		{
			idc=IDC_ADD_TEXT;
			text=CSTRING(MDL_T);
			colorBackgroundActive[]={0,0,0,0.89999998};
			font=QUOTE(EtelkaNarrowMediumPro);
			x=0;
			y=0;
			w=QUOTE(0.73 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			sizeEx=QUOTE(0.8 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,'T')] call FUNC(fastText));
		};
		class RscListbox_15000_color: RscListBox
		{
			idc=IDC_LB_COLOR;
			x=0;
			y=0;
			w=QUOTE(2 * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(10 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSelAdv));
		};
		class RscListbox_15001_pic: RscListBox
		{
			idc=IDC_LB_PIC;
			x=0;
			y=0;
			w=QUOTE(2 * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(10 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSelAdv));
		};
		class GVAR(RscControlsGroup): GVAR(RscControlsGroup)
		{
			idc=IDC_CONTROLS_GROUP;
			x=0;
			y=0;
			w=QUOTE(10 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(15 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			class controls
			{
				class Info_butt_1: GVAR(RscButtonMenu)
				{
					idc=IDC_CONTROLS_GROUP_INFO_BUTTON_1;
					text=QUOTE(Info);
					x=0;
					y=0;
					w=QUOTE(3.33 *  (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE([ARR_2(_this select 0,'info')] call FUNC(infoButtons));
				};
				class Info_butt_2: GVAR(RscButtonMenu)
				{
					idc=IDC_CONTROLS_GROUP_INFO_BUTTON_2;
					text=QUOTE(Sett);
					x=QUOTE(3.33*  (((safeZoneW/safeZoneH) min 1.2)/40));
					y=0;
					w=QUOTE(3.33 *  (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE([ARR_2(_this select 0,'sett')] call FUNC(infoButtons));
				};
				class Info_butt_3: GVAR(RscButtonMenu)
				{
					idc=IDC_CONTROLS_GROUP_INFO_BUTTON_3;
					text=QUOTE(Author);
					x=QUOTE(6.66*  (((safeZoneW/safeZoneH) min 1.2)/40));
					y=0;
					w=QUOTE(3.33 *  (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE([ARR_2(_this select 0,'author')] call FUNC(infoButtons));
				};
				class Info_12: RscStructuredText
				{
					colorBackground[]={0,0,0,0.69999999};
					idc=IDC_CONTROLS_GROUP_INFO;
					x=0;
					y=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					w=QUOTE(10 *  (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(23.5 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
			};
		};
		class GVAR(color_1200): GVAR(RscActivePicture)
		{
			idc=IDC_COLOR_00;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w=QUOTE((10/6) * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(0.7 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,0)] call FUNC(setColor));
		};
		class GVAR(color_1201): GVAR(RscActivePicture)
		{
			idc=IDC_COLOR_01;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w=QUOTE((10/6) * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(0.7 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,1)] call FUNC(setColor));
		};
		class GVAR(color_1202): GVAR(RscActivePicture)
		{
			idc=IDC_COLOR_02;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w=QUOTE((10/6) * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(0.7 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,2)] call FUNC(setColor));
		};
		class GVAR(color_1203): GVAR(RscActivePicture)
		{
			idc=IDC_COLOR_03;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w=QUOTE((10/6) * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(0.7 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,3)] call FUNC(setColor));
		};
		class GVAR(color_1204): GVAR(RscActivePicture)
		{
			idc=IDC_COLOR_04;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w=QUOTE((10/6) * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(0.7 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,4)] call FUNC(setColor));
		};
		class GVAR(color_1205): GVAR(RscActivePicture)
		{
			idc=IDC_COLOR_05;
			text="#(argb,8,8,3)color(1,1,1,1)";
			w=QUOTE((10/6) *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(0.7 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE([ARR_2(_this select 0,5)] call FUNC(setColor));
		};
		class GVAR(icon_1300): GVAR(RscButton)
		{
			idc=IDC_ICON_00;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick=QUOTE([ARR_2(_this select 0,0)] call FUNC(setIcon));
		};
		class GVAR(icon_1301): GVAR(RscButton)
		{
			idc=IDC_ICON_01;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick=QUOTE([ARR_2(_this select 0,1)] call FUNC(setIcon));
		};
		class GVAR(icon_1302): GVAR(RscButton)
		{
			idc=IDC_ICON_02;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick=QUOTE([ARR_2(_this select 0,2)] call FUNC(setIcon));
		};
		class GVAR(icon_1303): GVAR(RscButton)
		{
			idc=IDC_ICON_03;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick=QUOTE([ARR_2(_this select 0,3)] call FUNC(setIcon));
		};
		class GVAR(icon_1304): GVAR(RscButton)
		{
			idc=IDC_ICON_04;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick=QUOTE([ARR_2(_this select 0,4)] call FUNC(setIcon));
		};
		class GVAR(icon_1305): GVAR(RscButton)
		{
			idc=IDC_ICON_05;
			text="";
			w=0.050000001;
			h=0.0666667;
			OnButtonClick=QUOTE([ARR_2(_this select 0,5)] call FUNC(setIcon));
		};
		class GVAR(icon_1400): RscPicture
		{
			idc=IDC_ICON_10;
			text=QUOTE(\A3\ui_f\data\map\markers\military\dot_CA.paa);
			w=0.050000001;
			h=0.0666667;
		};
		class GVAR(icon_1401): RscPicture
		{
			idc=IDC_ICON_11;
			text=QUOTE(\A3\ui_f\data\map\markers\nato\o_inf.paa);
			w=0.050000001;
			h=0.0666667;
		};
		class GVAR(icon_1402): RscPicture
		{
			idc=IDC_ICON_12;
			text=QUOTE(\A3\ui_f\data\map\markers\nato\o_armor.paa);
			w=0.050000001;
			h=0.0666667;
		};
		class GVAR(icon_1403): RscPicture
		{
			idc=IDC_ICON_13;
			text=QUOTE(\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa);
			w=0.050000001;
			h=0.0666667;
		};
		class GVAR(icon_1404): RscPicture
		{
			idc=IDC_ICON_14;
			text=QUOTE(\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa);
			w=0.050000001;
			h=0.0666667;
		};
		class GVAR(icon_1405): RscPicture
		{
			idc=IDC_ICON_15;
			text=QUOTE(\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa);
			w=0.050000001;
			h=0.0666667;
		};
		class GVAR(RscCombo_2100): GVAR(RscCombo)
		{
			idc=IDC_COMBO_00;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2101): GVAR(RscCombo)
		{
			idc=IDC_COMBO_01;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2102): GVAR(RscCombo)
		{
			idc=IDC_COMBO_02;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2103): GVAR(RscCombo)
		{
			idc=IDC_COMBO_03;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2104): GVAR(RscCombo)
		{
			idc=IDC_COMBO_04;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2105): GVAR(RscCombo)
		{
			idc=IDC_COMBO_05;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2106): GVAR(RscCombo)
		{
			idc=IDC_COMBO_06;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2107): GVAR(RscCombo)
		{
			idc=IDC_COMBO_07;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2108): GVAR(RscCombo)
		{
			idc=IDC_COMBO_08;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2109): GVAR(RscCombo)
		{
			idc=IDC_COMBO_09;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2110): GVAR(RscCombo)
		{
			idc=IDC_COMBO_10;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(RscCombo_2111): GVAR(RscCombo)
		{
			idc=IDC_COMBO_11;
			x=0;
			y=0;
			w=QUOTE(5 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			onLBSelChanged=QUOTE(_this call FUNC(lbSel));
		};
		class GVAR(ButtonAdv): GVAR(RscButtonMenu)
		{
			idc=IDC_BUTTON_ADV;
			text=CSTRING(ADV);
			x=0;
			y=0;
			w=QUOTE(10 *  (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(1 *  ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			OnButtonClick=QUOTE(_this spawn FUNC(advancedSetButton));
		};
		class GVAR(RscControlsGroup_adv): GVAR(RscControlsGroup)
		{
			idc=IDC_CONTROLS_GROUP_ADV;
			x=0;
			y=0;
			w=QUOTE(25 * (((safeZoneW/safeZoneH) min 1.2)/40));
			h=QUOTE(20 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
			class controls
			{
				class adv_background: RscText
				{
					idc=IDC_ADV_BACKGROUND;
					x=0;
					y=0;
					w=QUOTE((21.1) * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(((3.5*0.9)+(4.5*0.9)+(7.5*0.9) + 2.5 * 0.9 + 0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					colorBackground[]={0,0,0,0.69999999};
					text="";
				};
				class first_block: RscText
				{
					style=QUOTE(66);
					x=QUOTE(0.15 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(0 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					text=CSTRING(SHOW_BUTTONS);
					w=QUOTE((9.7) * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE((3.5*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					SizeEx=QUOTE(0.8 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					colorText[]=
					{
						248/255,
						131/255,
						121/255,
						1
					};
				};
				class cb_show_butt: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SHOW_BUTTON;
					y=QUOTE((0.9)* ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SHOW OK')] spawn FUNC(checkBoxesSet));  
				};
				class text_show_butt: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SHOW_BUTTON;
					text=CSTRING(OKCAN);
					y=QUOTE((0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_show_info: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_SHOW_INFO;
					x=QUOTE((0.3) * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE((2*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SHOW _INFO')] spawn FUNC(checkBoxesSet));  
				};
				class text_show_info: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SHOW_INFO;
					text="INFO";
					y=QUOTE((2*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class Second_block: first_block
				{
					x=QUOTE(0.15 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE((3.5*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					text=CSTRING(CHOOSE);
					h=QUOTE((4.5*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_show_icon: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SHOW_ICON;
					y=QUOTE((3.5*0.9+0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SHOW ICON')] spawn FUNC(checkBoxesSet)); 
				};
				class text_show_icon: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SHOW_ICON;
					text=CSTRING(ICONS);
					y=QUOTE((3.5*0.9+0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_show_color: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SHOW_COLOR;
					y=QUOTE((3.5*0.9+2*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SHOW COLOR')] spawn FUNC(checkBoxesSet)); 
				};
				class text_show_color: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SHOW_COLOR;
					text=CSTRING(COLORS);
					y=QUOTE((3.5*0.9+2*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_show_lb: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SHOW_LB;
					y=QUOTE((3.5*0.9+3*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SHOW LB')] spawn FUNC(checkBoxesSet)); 
				};
				class text_show_lb: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SHOW_LB;
					text=CSTRING(ADVL);
					y=QUOTE((3.5*0.9+3*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class third_block: first_block
				{
					style=QUOTE(66);
					x=QUOTE(0.15 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(((3.5*0.9)+(4.5*0.9)) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					text=CSTRING(F);
					h=QUOTE((7.5*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					SizeEx=QUOTE(0.8 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_save_text: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SAVE_TEXT;
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SAVE TEXT')] spawn FUNC(checkBoxesSet)); 
				};
				class text_save_text: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SAVE_TEXT;
					text=CSTRING(SAVET);
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_save_mark: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SAVE_MARK;
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 2*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SAVE MARK')] spawn FUNC(checkBoxesSet)); 
				};
				class text_save_mark: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SAVE_MARK;
					text=CSTRING(SAVEM);
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 2*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_fast_load: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_FAST_LOAD;
					y=QUOTE(((3.5*0.9)+(4.5*0.9)+3*0.9)* ((((safeZoneW/safeZoneH) min 1.2) / 1.2) / 25));
					onButtonClick=QUOTE([ARR_2(_this,'FAST LOAD')] spawn FUNC(checkBoxesSet)); 
				};
				class text_fast_load: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_FAST_LOAD;
					text=CSTRING(FASTL);
					y=QUOTE(((3.5*0.9)+(4.5*0.9)+3*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_show_back: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_SHOW_BACK;
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 4*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'SHOW BACK')] spawn FUNC(checkBoxesSet)); 
				};
				class text_show_back: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_SHOW_BACK;
					text=CSTRING(BACKGROUND);
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 4*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_log: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_LOG;
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 5*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'_LOG')] spawn FUNC(checkBoxesSet)); 
				};
				class text_log: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_LOG;
					text=CSTRING(TEXT_LOG);
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 5*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class cb_markinfo: GVAR(RscCheckBox)
				{
					idc=IDC_ADV_CB_MARKINFO;
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 6*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onButtonClick=QUOTE([ARR_2(_this,'MARK _INFO')] spawn FUNC(checkBoxesSet)); 
				};
				class text_markimfo: GVAR(RscStructuredText)
				{
					idc=IDC_ADV_TEXT_MARKINFO;
					text=CSTRING(MARKINFO);
					y=QUOTE(((3.5*0.9)+(4.5*0.9) + 6*0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class GVAR(text_saved): first_block
				{
					idc=-1;
					text=CSTRING(SAVEDTEXT);
					x=QUOTE(0.3 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(((3.5*0.9)+(4.5*0.9)+(7.5*0.9)) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					h=QUOTE(2.5 * 0.9 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class GVAR(edit_saved): RscEdit
				{
					idc=IDC_ADV_EDIT_SAVED;
					text="";
					x=QUOTE(0.45 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(((3.5*0.9)+(4.5*0.9)+(7.5*0.9) + 0.9) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					w=QUOTE(9.2 * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(1 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					onKeyUp=QUOTE(GVAR(fastTextTSaved) = ctrlText (_this select 0); GVAR(settingsParams) set [ARR_2(9,GVAR(fastTextTSaved))]; profileNamespace setVariable [ARR_2('GVAR(settingsParams)',GVAR(settingsParams))]; saveProfileNamespace;);
					color[]={1,1,1,1};
				};
				class GVAR(text_markersmap): first_block
				{
					idc=IDC_ADV_TEXT_MARKERS_MAP;
					text=CSTRING(SAVEDM);
					x=QUOTE(10.2 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(0 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					w=QUOTE(10.8 * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE((9 + 9*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class GVAR(text_markerspr): first_block
				{
					idc=IDC_ADV_TEXT_MARKERS_PR;
					text=CSTRING(INPROF);
					x=QUOTE(10.4 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(1* ((((safeZoneW/safeZoneH) min 1.2) /1.2) /25));
					w=QUOTE(10.4 * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE((4+4*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class GVAR(ButtonSAVE): GVAR(RscButtonMenu)
				{
					idc=IDC_ADV_BUTTON_SAVE;
					text=CSTRING(SAVE);
					x=QUOTE(10.6 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE(2 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					size=QUOTE(0.85 * (((((safeZoneW/safeZoneH) min 1.2)/1.2)/25) * 1));
					OnButtonClick=QUOTE(_this call FUNC(saveMarkers));
				};
				class GVAR(ButtonLOAD): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_LOAD;
					text=CSTRING(LOAD);
					y=QUOTE((3 + 1*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE([_this] call FUNC(loadMarkers));
				};
				class GVAR(ButtonUnload): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_UNLOAD;
					text=CSTRING(UNLOAD);
					y=QUOTE((4 + 2*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE(profileNamespace setVariable [ARR_2('GVAR(saveArr)',[])];saveProfileNamespace;);
				};
				class GVAR(text_clip): first_block
				{
					idc=IDC_ADV_TEXT_CLIP;
					text=CSTRING(CLIP);
					x=QUOTE(10.4 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE((5 + 3*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					w=QUOTE(10.4 * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE((4+4*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
				};
				class GVAR(ButtonSaveClp): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_SAVE_CLIP;
					text=CSTRING(SAVE);
					y=QUOTE((6 + 3*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE('CLIP' call FUNC(saveMarkers));
				};
				class GVAR(Edit): RscEdit
				{
					idc=IDC_ADV_EDIT;
					text=CSTRING(ENTERARRAY);
					x=QUOTE(10.6 * (((safeZoneW/safeZoneH) min 1.2)/40));
					y=QUOTE((7 + 4*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					w=QUOTE(10 * (((safeZoneW/safeZoneH) min 1.2)/40));
					h=QUOTE(1 * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					size=QUOTE(0.85*(((((safeZoneW/safeZoneH) min 1.2)/1.2)/25) * 1));
				};
				class GVAR(ButtonClpLoad): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_CLP_LOAD;
					text=CSTRING(LOAD);
					y=QUOTE((8 + 5*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					OnButtonClick=QUOTE([ARR_2(_this,ctrlText ((ctrlParent (_this select 0)) displayCtrl 653))] call FUNC(loadMarkers));
				};
				class GVAR(Buttondef): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_DEF;
					text=CSTRING(DEF);
					y=QUOTE((9 + 10*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					colorBackground[]={0.95700002,0,0,0.80000001};
					color[]={0,0,0,1};
					OnButtonClick=QUOTE(call FUNC(def); (ctrlParent (_this select 0)) closeDisplay 0;);
				};
				class GVAR(ButtonClear): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_CLEAR;
					text=CSTRING(CLEARMAP);
					y=QUOTE((10 + 11*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					colorBackground[]={0.95700002,0,0,0.80000001};
					color[]={0,0,0,1};
					OnButtonClick=QUOTE(call FUNC(clearMap));
				};
				class GVAR(ButtonDisable): GVAR(ButtonSAVE)
				{
					idc=IDC_ADV_BUTTON_DISABLE;
					text=CSTRING(DISABLE);
					y=QUOTE((11 + 12*0.15) * ((((safeZoneW/safeZoneH) min 1.2)/1.2)/25));
					colorBackground[]={0.95700002,0,0,0.80000001};
					color[]={0,0,0,1};
					OnButtonClick=QUOTE((_this select 0) call FUNC(disableLoc));
				};
			};
		};
	};
};