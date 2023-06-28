GDPC                                                                                <   res://.import/icon.png-b6a7fb2db36edd3d95dc42f1dc8c1c5d.stexP      �      &�y���ڞu;>��.p8   res://addons/fps_graph_overlay/FPSGraphOverlay.gd.remap �%      C       ��4��&	�V)���{�4   res://addons/fps_graph_overlay/FPSGraphOverlay.gdc  �      �      ��9F�4�'�$���)4   res://addons/fps_graph_overlay/FPSGraphOverlay.tscn p      >      R�6�#������
a<0   res://addons/fps_graph_overlay/plugin.gd.remap  �%      :       ;��G����-ۛ��n,   res://addons/fps_graph_overlay/plugin.gdc   �      �      b�%��Y�w�`�n�@^l   res://assets/icon.png   `&      �      G1?��z�c��vN��   res://assets/icon.png.import0      �      &�Q��~��X�М�   res://default_env.tres  �            E���\(Ȁ~�;�\�   res://project.binaryP3      �      1|j�)x^%�m���c,   res://resources/circle_pixel_material.tres         U      ˔h��f`�[�)b�   res://scenes/main.tscn  `      �      W�$���2	椰t���    res://scripts/greeter.gd.remap  0&      *       ���`_�3L��8o�P   res://scripts/greeter.gdc    "            �'��V��G :�L"�$   res://shaders/circle_pixel.shader    #      y      [��2ݜ8�L �^?�0GDSC   (   	   >   d     ����������Ķ   ���������������������Ŷ�   ���������������ض���   ������Ŷ   �������Ї���������¶   ����Ӷ��   ���ӄ�   ���Ӷ���   �����Ķ�   ����Ķ��   �����ڶ�   ����ڶ��   �����������Ӷ���   ����������������¶��   ���Ӷ���   �����������������ض�   ����޶��   �������׶���   �����϶�   ������Ӷ   ζ��   ߶��   ��������¶��   ϶��   ����¶��   �ն�   ������¶   �����¶�   ����¶��   ���������¶�   ������������϶��   ����������������Ӷ��   ��������   ���������Ҷ�   �����Ŷ�   ��Ŷ   �����Ӷ�   ��������������������Ҷ��   ���¶���   ����������������¶��         x      <               @             timeout       _on_timer_timeout                                                     	   	      
         *      5      6      ?      H      Q      R      S      a      m      r      s      t      |      �      �      �      �      �      �      �       �   !   �   "   �   #   �   $   �   %   �   &   �   '   �   (   �   )   �   *   �   +   �   ,   �   -   �   .   �   /   �   0     1     2     3   &  4   '  5   2  6   7  7   H  8   J  9   K  :   T  ;   U  <   V  =   ^  >   b  ?   YYYYYY3YY8P�  Q;�  V�  Y8P�  Q;�  V�  �  Y8P�  Q;�  V�  �  Y8P�  Q;�  V�  �  YY5;�  V�  W�  Y5;�  V�	  W�	  Y5;�
  V�  W�  YYY5;�  V�  �  T�  PQT�  Y5;�  V�  �  T�  �  Y;�  V�  YYY0�  PQX=V�  �  �  Y�  �  �  T�  �  Y�  �  Y�  )�  �  V�  �  T�  P�  P�  �  R�  T�  �  QQY�  �  T�  P�  Q�  ;�  �  T�  P�  RR�  QYYY0�  P�  V�  QX=V�  &�  V�  .�  &�  4�  �  T�  �   �  T�!  PQV�  .Y�  �  �  YYY0�  PQX=V�  )�  �K  PR�  QV�  �  T�"  L�  M�  T�"  L�  M�  P�  R�  QY�  ;�#  V�  �$  T�%  PQY�  �  T�"  LM�  P�  �  T�  R�  �!  P�#  R�  R�  R�  T�  �  R�  Q�  QY�  �
  T�&  �>  P�#  QYYY0�'  PQX=V�  �  PQY`            ; SPDX-FileCopyrightText: 2023 Sander Vanhove <sandervhove@gmail.com>
;
; SPDX-License-Identifier: MIT
;
; Source: https://github.com/SanderVanhove/godot-fps-graph-overlay

[gd_scene load_steps=6 format=2]

[ext_resource path="res://addons/fps_graph_overlay/FPSGraphOverlay.gd" type="Script" id=1]

[sub_resource type="Shader" id=8]
code = "shader_type canvas_item;

uniform sampler2D gradient;

void fragment() {
	COLOR = texture(gradient, vec2(SCREEN_UV.y, 0.0));
}"

[sub_resource type="Gradient" id=10]
offsets = PoolRealArray( 0, 0.0688073, 0.238532, 0.444954, 1 )
colors = PoolColorArray( 1, 0, 0, 1, 1, 0.0910375, 0.0120563, 1, 1, 0.737404, 0.0976563, 1, 0.0820883, 0.978916, 0.00784101, 1, 0.00195313, 1, 0, 1 )

[sub_resource type="GradientTexture" id=11]
gradient = SubResource( 10 )
width = 1000

[sub_resource type="ShaderMaterial" id=9]
shader = SubResource( 8 )
shader_param/gradient = SubResource( 11 )

[node name="FPSGraphOverlay" type="CanvasLayer"]
layer = 100
script = ExtResource( 1 )

[node name="Line" type="Line2D" parent="."]
modulate = Color( 1, 1, 1, 0.392157 )
material = SubResource( 9 )

[node name="Timer" type="Timer" parent="."]

[node name="Label" type="Label" parent="."]
anchor_left = 1.0
anchor_top = 1.0
anchor_right = 1.0
anchor_bottom = 1.0
margin_left = -55.0
margin_top = -14.0
text = "60"
align = 2
  GDSC            ,      �����������ض���   ����������Ӷ   ���������������������ض�   ���������Ӷ�   ������������������������ض��      FPSGraphOverlay    3   res://addons/fps_graph_overlay/FPSGraphOverlay.tscn                                            
   	      
                                 %      *      YYYYYY6Y3YYY0�  PQX=V�  �  PR�  QYYY0�  PQX=V�  �  PQY`   GDST@   @            �  WEBPRIFF�  WEBPVP8L�  /?����m��������_"�0@��^�"�v��s�}� �W��<f��Yn#I������wO���M`ҋ���N��m:�
��{-�4b7DԧQ��A �B�P��*B��v��
Q�-����^R�D���!(����T�B�*�*���%E["��M�\͆B�@�U$R�l)���{�B���@%P����g*Ųs�TP��a��dD
�6�9�UR�s����1ʲ�X�!�Ha�ߛ�$��N����i�a΁}c Rm��1��Q�c���fdB�5������J˚>>���s1��}����>����Y��?�TEDױ���s���\�T���4D����]ׯ�(aD��Ѓ!�a'\�G(��$+c$�|'�>����/B��c�v��_oH���9(l�fH������8��vV�m�^�|�m۶m�����q���k2�='���:_>��������á����-wӷU�x�˹�fa���������ӭ�M���SƷ7������|��v��v���m�d���ŝ,��L��Y��ݛ�X�\֣� ���{�#3���
�6������t`�
��t�4O��ǎ%����u[B�����O̲H��o߾��$���f���� �H��\��� �kߡ}�~$�f���N\�[�=�'��Nr:a���si����(9Lΰ���=����q-��W��LL%ɩ	��V����R)�=jM����d`�ԙHT�c���'ʦI��DD�R��C׶�&����|t Sw�|WV&�^��bt5WW,v�Ş�qf���+���Jf�t�s�-BG�t�"&�Ɗ����׵�Ջ�KL�2)gD� ���� NEƋ�R;k?.{L�$�y���{'��`��ٟ��i��{z�5��i������c���Z^�
h�+U�mC��b��J��uE�c�����h��}{�����i�'�9r�����ߨ򅿿��hR�Mt�Rb���C�DI��iZ�6i"�DN�3���J�zڷ#oL����Q �W��D@!'��;�� D*�K�J�%"�0�����pZԉO�A��b%�l�#��$A�W�A�*^i�$�%a��rvU5A�ɺ�'a<��&�DQ��r6ƈZC_B)�N�N(�����(z��y�&H�ض^��1Z4*,RQjԫ׶c����yq��4���?�R�����0�6f2Il9j��ZK�4���է�0؍è�ӈ�Uq�3�=[vQ�d$���±eϘA�����R�^��=%:�G�v��)�ǖ/��RcO���z .�ߺ��S&Q����o,X�`�����|��s�<3Z��lns'���vw���Y��>V����G�nuk:��5�U.�v��|����W���Z���4�@U3U�������|�r�?;�
         [remap]

importer="texture"
type="StreamTexture"
path="res://.import/icon.png-b6a7fb2db36edd3d95dc42f1dc8c1c5d.stex"
metadata={
"vram_texture": false
}

[deps]

source_file="res://assets/icon.png"
dest_files=[ "res://.import/icon.png-b6a7fb2db36edd3d95dc42f1dc8c1c5d.stex" ]

[params]

compress/mode=0
compress/lossy_quality=0.7
compress/hdr_mode=0
compress/bptc_ldr=0
compress/normal_map=0
flags/repeat=0
flags/filter=true
flags/mipmaps=false
flags/anisotropic=false
flags/srgb=2
process/fix_alpha_border=true
process/premult_alpha=false
process/HDR_as_SRGB=false
process/invert_color=false
process/normal_map_invert_y=false
stream=false
size_limit=0
detect_3d=true
svg/scale=1.0
       ; SPDX-FileCopyrightText: 2023 Florian Vazelle <florian.vazelle@vivaldi.net>
;
; SPDX-License-Identifier: MIT

[gd_resource type="Environment" load_steps=2 format=2]

[sub_resource type="ProceduralSky" id=1]

[resource]
background_mode = 2
background_sky = SubResource( 1 )
              ; SPDX-FileCopyrightText: 2023 Florian Vazelle <florian.vazelle@vivaldi.net>
;
; SPDX-License-Identifier: MIT

[gd_resource type="ShaderMaterial" load_steps=2 format=2]

[ext_resource path="res://shaders/circle_pixel.shader" type="Shader" id=1]

[resource]
shader = ExtResource( 1 )
shader_param/amount_x = 50.0
shader_param/amount_y = 50.0
           ; SPDX-FileCopyrightText: 2023 Florian Vazelle <florian.vazelle@vivaldi.net>
;
; SPDX-License-Identifier: MIT

[gd_scene load_steps=3 format=2]

[ext_resource path="res://scripts/greeter.gd" type="Script" id=1]
[ext_resource path="res://resources/circle_pixel_material.tres" type="Material" id=2]

[node name="Main" type="Node"]

[node name="ViewportContainer" type="ViewportContainer" parent="."]
material = ExtResource( 2 )
anchor_right = 1.0
anchor_bottom = 1.0
stretch = true

[node name="Viewport" type="Viewport" parent="ViewportContainer"]
size = Vector2( 1024, 600 )
transparent_bg = true
handle_input_locally = false
render_target_update_mode = 3

[node name="Camera" type="Camera" parent="ViewportContainer/Viewport"]
transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 5 )

[node name="Greeter" type="Label3D" parent="ViewportContainer/Viewport"]
pixel_size = 0.15
script = ExtResource( 1 )
player_name = "John"
 GDSC            '      ������Ķ   ����څ�   ����������Ӷ   �����϶�   �������¶���      Hello         !                                        
         	      
                     %      YYYY2YY3�  YY8P�  Q;�  YYY0�  PQX=V�  �  P�  �  QY` // SPDX-FileCopyrightText: 2023 jijiji
//
// SPDX-License-Identifier: CC0-1.0
//
// Source: https://godotshaders.com/shader/circle-pixel/

shader_type canvas_item;

uniform float amount_x: hint_range(0, 128) = 8;
uniform float amount_y: hint_range(0, 128) = 8;

void fragment() {
	vec2 pos = UV;
	pos *= vec2(amount_x, amount_y);
	pos = ceil(pos);
	pos /= vec2(amount_x, amount_y);
	vec2 cellpos = pos - (0.5 / vec2(amount_x, amount_y));

	pos -= UV;
	pos *= vec2(amount_x, amount_y);
	pos = vec2(1.0) - pos;

	float dist = distance(pos, vec2(0.5));

	vec4 c = texture(TEXTURE, cellpos);
	COLOR = c * step(0.0, (0.5* c.a) - dist);
}
       [remap]

path="res://addons/fps_graph_overlay/FPSGraphOverlay.gdc"
             [remap]

path="res://addons/fps_graph_overlay/plugin.gdc"
      [remap]

path="res://scripts/greeter.gdc"
      �PNG

   IHDR   @   @   �iq�   sRGB ���  �IDATx��ytTU��?�ի%���@ȞY1JZ �iA�i�[P��e��c;�.`Ow+4�>�(}z�EF�Dm�:�h��IHHB�BR!{%�Zߛ?��	U�T�
���:��]~�������-�	Ì�{q*�h$e-
�)��'�d�b(��.�B�6��J�ĩ=;���Cv�j��E~Z��+��CQ�AA�����;�.�	�^P	���ARkUjQ�b�,#;�8�6��P~,� �0�h%*QzE� �"��T��
�=1p:lX�Pd�Y���(:g����kZx ��A���띊3G�Di� !�6����A҆ @�$JkD�$��/�nYE��< Q���<]V�5O!���>2<��f��8�I��8��f:a�|+�/�l9�DEp�-�t]9)C�o��M~�k��tw�r������w��|r�Ξ�	�S�)^� ��c�eg$�vE17ϟ�(�|���Ѧ*����
����^���uD�̴D����h�����R��O�bv�Y����j^�SN֝
������PP���������Y>����&�P��.3+�$��ݷ�����{n����_5c�99�fbסF&�k�mv���bN�T���F���A�9�
(.�'*"��[��c�{ԛmNު8���3�~V� az
�沵�f�sD��&+[���ke3o>r��������T�]����* ���f�~nX�Ȉ���w+�G���F�,U�� D�Դ0赍�!�B�q�c�(
ܱ��f�yT�:��1�� +����C|��-�T��D�M��\|�K�j��<yJ, ����n��1.FZ�d$I0݀8]��Jn_� ���j~����ցV���������1@M�)`F�BM����^x�>
����`��I�˿��wΛ	����W[�����v��E�����u��~��{R�(����3���������y����C��!��nHe�T�Z�����K�P`ǁF´�nH啝���=>id,�>�GW-糓F������m<P8�{o[D����w�Q��=N}�!+�����-�<{[���������w�u�L�����4�����Uc�s��F�륟��c�g�u�s��N��lu���}ן($D��ת8m�Q�V	l�;��(��ڌ���k�
s\��JDIͦOzp��مh����T���IDI���W�Iǧ�X���g��O��a�\:���>����g���%|����i)	�v��]u.�^�:Gk��i)	>��T@k{'	=�������@a�$zZ�;}�󩀒��T�6�Xq&1aWO�,&L�cřT�4P���g[�
p�2��~;� ��Ҭ�29�xri� ��?��)��_��@s[��^�ܴhnɝ4&'
��NanZ4��^Js[ǘ��2���x?Oܷ�$��3�$r����Q��1@�����~��Y�Qܑ�Hjl(}�v�4vSr�iT�1���f������(���A�ᥕ�$� X,�3'�0s����×ƺk~2~'�[�ё�&F�8{2O�y�n�-`^/FPB�?.�N�AO]]�� �n]β[�SR�kN%;>�k��5������]8������=p����Ցh������`}�
�J�8-��ʺ����� �fl˫[8�?E9q�2&������p��<�r�8x� [^݂��2�X��z�V+7N����V@j�A����hl��/+/'5�3�?;9
�(�Ef'Gyҍ���̣�h4RSS� ����������j�Z��jI��x��dE-y�a�X�/�����:��� +k�� �"˖/���+`��],[��UVV4u��P �˻�AA`��)*ZB\\��9lܸ�]{N��礑]6�Hnnqqq-a��Qxy�7�`=8A�Sm&�Q�����u�0hsPz����yJt�[�>�/ޫ�il�����.��ǳ���9��
_
��<s���wT�S������;F����-{k�����T�Z^���z�!t�۰؝^�^*���؝c
���;��7]h^
��PA��+@��gA*+�K��ˌ�)S�1��(Ե��ǯ�h����õ�M�`��p�cC�T")�z�j�w��V��@��D��N�^M\����m�zY��C�Ҙ�I����N�Ϭ��{�9�)����o���C���h�����ʆ.��׏(�ҫ���@�Tf%yZt���wg�4s�]f�q뗣�ǆi�l�⵲3t��I���O��v;Z�g��l��l��kAJѩU^wj�(��������{���)�9�T���KrE�V!�D���aw���x[�I��tZ�0Y �%E�͹���n�G�P�"5FӨ��M�K�!>R���$�.x����h=gϝ�K&@-F��=}�=�����5���s �CFwa���8��u?_����D#���x:R!5&��_�]���*�O��;�)Ȉ�@�g�����ou�Q�v���J�G�6�P�������7��-���	պ^#�C�S��[]3��1���IY��.Ȉ!6\K�:��?9�Ev��S]�l;��?/� ��5�p�X��f�1�;5�S�ye��Ƅ���,Da�>�� O.�AJL(���pL�C5ij޿hBƾ���ڎ�)s��9$D�p���I��e�,ə�+;?�t��v�p�-��&����	V���x���yuo-G&8->�xt�t������Rv��Y�4ZnT�4P]�HA�4�a�T�ǅ1`u\�,���hZ����S������o翿���{�릨ZRq��Y��fat�[����[z9��4�U�V��Anb$Kg������]������8�M0(WeU�H�\n_��¹�C�F�F�}����8d�N��.��]���u�,%Z�F-���E�'����q�L�\������=H�W'�L{�BP0Z���Y�̞���DE��I�N7���c��S���7�Xm�/`�	�+`����X_��KI��^��F\�aD�����~�+M����ㅤ��	SY��/�.�`���:�9Q�c �38K�j�0Y�D�8����W;ܲ�pTt��6P,� Nǵ��Æ�:(���&�N�/ X��i%�?�_P	�n�F�.^�G�E���鬫>?���"@v�2���A~�aԹ_[P, n��N������_rƢ��    IEND�B`�       ECFG      _global_script_classes�                     base      Label3D       class         Greeter       language      GDScript      path      res://scripts/greeter.gd   _global_script_class_icons                Greeter           application/config/name         Greeter    application/run/main_scene          res://scenes/main.tscn     application/config/icon          res://assets/icon.png      autoload/FPSGraphOverlay<      4   *res://addons/fps_graph_overlay/FPSGraphOverlay.tscn   editor_plugins/enabled8         *   res://addons/fps_graph_overlay/plugin.cfg   )   rendering/environment/default_environment          res://default_env.tres               