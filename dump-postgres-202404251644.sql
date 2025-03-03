PGDMP  $    ,                |            postgres    16.2    16.2 -    E           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            F           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            G           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            H           1262    5    postgres    DATABASE     |   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE postgres;
                postgres    false            I           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    4936            	            2615    24576    PM02    SCHEMA        CREATE SCHEMA "PM02";
    DROP SCHEMA "PM02";
                postgres    false            �            1259    32784    measurements    TABLE       CREATE TABLE "PM02".measurements (
    sensor_inventory_number uuid NOT NULL,
    measurement_value numeric(17,2) NOT NULL,
    measurement_ts timestamp without time zone DEFAULT now() NOT NULL,
    measurement_type integer NOT NULL,
    measurement_id integer NOT NULL
);
     DROP TABLE "PM02".measurements;
       PM02         heap    postgres    false    9            �            1259    32881    measurements_measurement_id_seq    SEQUENCE     �   CREATE SEQUENCE "PM02".measurements_measurement_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE "PM02".measurements_measurement_id_seq;
       PM02          postgres    false    252    9            J           0    0    measurements_measurement_id_seq    SEQUENCE OWNED BY     c   ALTER SEQUENCE "PM02".measurements_measurement_id_seq OWNED BY "PM02".measurements.measurement_id;
          PM02          postgres    false    253            �            1259    24600    measurements_type    TABLE     I  CREATE TABLE "PM02".measurements_type (
    type_id integer NOT NULL,
    type_name character varying NOT NULL,
    type_units character(4) NOT NULL,
    CONSTRAINT measurements_type_type_name_check CHECK ((length((type_name)::text) <= 31)),
    CONSTRAINT measurements_type_type_units_check CHECK ((length(type_units) <= 4))
);
 %   DROP TABLE "PM02".measurements_type;
       PM02         heap    postgres    false    9            �            1259    24599    measurements_type_type_id_seq    SEQUENCE     �   CREATE SEQUENCE "PM02".measurements_type_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 4   DROP SEQUENCE "PM02".measurements_type_type_id_seq;
       PM02          postgres    false    9    249            K           0    0    measurements_type_type_id_seq    SEQUENCE OWNED BY     _   ALTER SEQUENCE "PM02".measurements_type_type_id_seq OWNED BY "PM02".measurements_type.type_id;
          PM02          postgres    false    248            �            1259    24578    meteostations    TABLE     _  CREATE TABLE "PM02".meteostations (
    station_id integer NOT NULL,
    station_name character varying NOT NULL,
    station_longitude numeric(5,2) NOT NULL,
    station_latitude numeric(5,2) NOT NULL,
    CONSTRAINT meteostations_station_latitude_check CHECK (((station_latitude <= (180)::numeric) OR (station_latitude >= ('-180'::integer)::numeric))),
    CONSTRAINT meteostations_station_longitude_check CHECK (((station_longitude <= (180)::numeric) OR (station_longitude >= ('-180'::integer)::numeric))),
    CONSTRAINT meteostations_station_name_check CHECK ((length((station_name)::text) <= 127))
);
 !   DROP TABLE "PM02".meteostations;
       PM02         heap    postgres    false    9            �            1259    32768    meteostations_sensors    TABLE     N  CREATE TABLE "PM02".meteostations_sensors (
    sensor_inventory_number uuid DEFAULT gen_random_uuid() NOT NULL,
    station_id integer NOT NULL,
    sensor_id integer NOT NULL,
    added_ts timestamp without time zone NOT NULL,
    removed_ts timestamp without time zone DEFAULT '9999-01-01 00:00:00'::timestamp without time zone
);
 )   DROP TABLE "PM02".meteostations_sensors;
       PM02         heap    postgres    false    9            �            1259    24577    meteostations_station_id_seq    SEQUENCE     �   CREATE SEQUENCE "PM02".meteostations_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE "PM02".meteostations_station_id_seq;
       PM02          postgres    false    9    245            L           0    0    meteostations_station_id_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE "PM02".meteostations_station_id_seq OWNED BY "PM02".meteostations.station_id;
          PM02          postgres    false    244            �            1259    24590    sensors    TABLE     �   CREATE TABLE "PM02".sensors (
    sensor_id integer NOT NULL,
    sensor_name character varying NOT NULL,
    CONSTRAINT sensors_sensor_name_check CHECK ((length((sensor_name)::text) <= 31))
);
    DROP TABLE "PM02".sensors;
       PM02         heap    postgres    false    9            �            1259    24613    sensors_measurements    TABLE       CREATE TABLE "PM02".sensors_measurements (
    sensor_id integer NOT NULL,
    type_id integer NOT NULL,
    measurment_formula character varying NOT NULL,
    CONSTRAINT sensors_measurements_measurment_formula_check CHECK ((length((measurment_formula)::text) <= 255))
);
 (   DROP TABLE "PM02".sensors_measurements;
       PM02         heap    postgres    false    9            �            1259    24589    sensors_sensor_id_seq    SEQUENCE     �   CREATE SEQUENCE "PM02".sensors_sensor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE "PM02".sensors_sensor_id_seq;
       PM02          postgres    false    247    9            M           0    0    sensors_sensor_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE "PM02".sensors_sensor_id_seq OWNED BY "PM02".sensors.sensor_id;
          PM02          postgres    false    246            �           2604    32882    measurements measurement_id    DEFAULT     �   ALTER TABLE ONLY "PM02".measurements ALTER COLUMN measurement_id SET DEFAULT nextval('"PM02".measurements_measurement_id_seq'::regclass);
 J   ALTER TABLE "PM02".measurements ALTER COLUMN measurement_id DROP DEFAULT;
       PM02          postgres    false    253    252            �           2604    24603    measurements_type type_id    DEFAULT     �   ALTER TABLE ONLY "PM02".measurements_type ALTER COLUMN type_id SET DEFAULT nextval('"PM02".measurements_type_type_id_seq'::regclass);
 H   ALTER TABLE "PM02".measurements_type ALTER COLUMN type_id DROP DEFAULT;
       PM02          postgres    false    248    249    249            �           2604    24581    meteostations station_id    DEFAULT     �   ALTER TABLE ONLY "PM02".meteostations ALTER COLUMN station_id SET DEFAULT nextval('"PM02".meteostations_station_id_seq'::regclass);
 G   ALTER TABLE "PM02".meteostations ALTER COLUMN station_id DROP DEFAULT;
       PM02          postgres    false    244    245    245            �           2604    24593    sensors sensor_id    DEFAULT     v   ALTER TABLE ONLY "PM02".sensors ALTER COLUMN sensor_id SET DEFAULT nextval('"PM02".sensors_sensor_id_seq'::regclass);
 @   ALTER TABLE "PM02".sensors ALTER COLUMN sensor_id DROP DEFAULT;
       PM02          postgres    false    247    246    247            A          0    32784    measurements 
   TABLE DATA           �   COPY "PM02".measurements (sensor_inventory_number, measurement_value, measurement_ts, measurement_type, measurement_id) FROM stdin;
    PM02          postgres    false    252   #;       >          0    24600    measurements_type 
   TABLE DATA           K   COPY "PM02".measurements_type (type_id, type_name, type_units) FROM stdin;
    PM02          postgres    false    249   (?       :          0    24578    meteostations 
   TABLE DATA           f   COPY "PM02".meteostations (station_id, station_name, station_longitude, station_latitude) FROM stdin;
    PM02          postgres    false    245   t?       @          0    32768    meteostations_sensors 
   TABLE DATA           u   COPY "PM02".meteostations_sensors (sensor_inventory_number, station_id, sensor_id, added_ts, removed_ts) FROM stdin;
    PM02          postgres    false    251   pR       <          0    24590    sensors 
   TABLE DATA           9   COPY "PM02".sensors (sensor_id, sensor_name) FROM stdin;
    PM02          postgres    false    247   Z       ?          0    24613    sensors_measurements 
   TABLE DATA           V   COPY "PM02".sensors_measurements (sensor_id, type_id, measurment_formula) FROM stdin;
    PM02          postgres    false    250   WZ       N           0    0    measurements_measurement_id_seq    SEQUENCE SET     N   SELECT pg_catalog.setval('"PM02".measurements_measurement_id_seq', 34, true);
          PM02          postgres    false    253            O           0    0    measurements_type_type_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('"PM02".measurements_type_type_id_seq', 3, true);
          PM02          postgres    false    248            P           0    0    meteostations_station_id_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('"PM02".meteostations_station_id_seq', 26, true);
          PM02          postgres    false    244            Q           0    0    sensors_sensor_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('"PM02".sensors_sensor_id_seq', 3, true);
          PM02          postgres    false    246            �           2606    32887    measurements measurements_pk 
   CONSTRAINT     f   ALTER TABLE ONLY "PM02".measurements
    ADD CONSTRAINT measurements_pk PRIMARY KEY (measurement_id);
 F   ALTER TABLE ONLY "PM02".measurements DROP CONSTRAINT measurements_pk;
       PM02            postgres    false    252            �           2606    24609 &   measurements_type measurements_type_pk 
   CONSTRAINT     i   ALTER TABLE ONLY "PM02".measurements_type
    ADD CONSTRAINT measurements_type_pk PRIMARY KEY (type_id);
 P   ALTER TABLE ONLY "PM02".measurements_type DROP CONSTRAINT measurements_type_pk;
       PM02            postgres    false    249            �           2606    24588    meteostations meteostations_pk 
   CONSTRAINT     d   ALTER TABLE ONLY "PM02".meteostations
    ADD CONSTRAINT meteostations_pk PRIMARY KEY (station_id);
 H   ALTER TABLE ONLY "PM02".meteostations DROP CONSTRAINT meteostations_pk;
       PM02            postgres    false    245            �           2606    32773 .   meteostations_sensors meteostations_sensors_pk 
   CONSTRAINT     �   ALTER TABLE ONLY "PM02".meteostations_sensors
    ADD CONSTRAINT meteostations_sensors_pk PRIMARY KEY (sensor_inventory_number);
 X   ALTER TABLE ONLY "PM02".meteostations_sensors DROP CONSTRAINT meteostations_sensors_pk;
       PM02            postgres    false    251            �           2606    24598    sensors sensors_pk 
   CONSTRAINT     W   ALTER TABLE ONLY "PM02".sensors
    ADD CONSTRAINT sensors_pk PRIMARY KEY (sensor_id);
 <   ALTER TABLE ONLY "PM02".sensors DROP CONSTRAINT sensors_pk;
       PM02            postgres    false    247            �           2606    32792 .   measurements measurements_measurements_type_fk    FK CONSTRAINT     �   ALTER TABLE ONLY "PM02".measurements
    ADD CONSTRAINT measurements_measurements_type_fk FOREIGN KEY (measurement_type) REFERENCES "PM02".measurements_type(type_id);
 X   ALTER TABLE ONLY "PM02".measurements DROP CONSTRAINT measurements_measurements_type_fk;
       PM02          postgres    false    4767    252    249            �           2606    32787 2   measurements measurements_meteostations_sensors_fk    FK CONSTRAINT     �   ALTER TABLE ONLY "PM02".measurements
    ADD CONSTRAINT measurements_meteostations_sensors_fk FOREIGN KEY (sensor_inventory_number) REFERENCES "PM02".meteostations_sensors(sensor_inventory_number);
 \   ALTER TABLE ONLY "PM02".measurements DROP CONSTRAINT measurements_meteostations_sensors_fk;
       PM02          postgres    false    252    4769    251            �           2606    32774 <   meteostations_sensors meteostations_sensors_meteostations_fk    FK CONSTRAINT     �   ALTER TABLE ONLY "PM02".meteostations_sensors
    ADD CONSTRAINT meteostations_sensors_meteostations_fk FOREIGN KEY (station_id) REFERENCES "PM02".meteostations(station_id);
 f   ALTER TABLE ONLY "PM02".meteostations_sensors DROP CONSTRAINT meteostations_sensors_meteostations_fk;
       PM02          postgres    false    245    4763    251            �           2606    32779 6   meteostations_sensors meteostations_sensors_sensors_fk    FK CONSTRAINT     �   ALTER TABLE ONLY "PM02".meteostations_sensors
    ADD CONSTRAINT meteostations_sensors_sensors_fk FOREIGN KEY (sensor_id) REFERENCES "PM02".sensors(sensor_id);
 `   ALTER TABLE ONLY "PM02".meteostations_sensors DROP CONSTRAINT meteostations_sensors_sensors_fk;
       PM02          postgres    false    4765    251    247            �           2606    24624 >   sensors_measurements sensors_measurements_measurements_type_fk    FK CONSTRAINT     �   ALTER TABLE ONLY "PM02".sensors_measurements
    ADD CONSTRAINT sensors_measurements_measurements_type_fk FOREIGN KEY (type_id) REFERENCES "PM02".measurements_type(type_id);
 h   ALTER TABLE ONLY "PM02".sensors_measurements DROP CONSTRAINT sensors_measurements_measurements_type_fk;
       PM02          postgres    false    4767    249    250            �           2606    24619 4   sensors_measurements sensors_measurements_sensors_fk    FK CONSTRAINT     �   ALTER TABLE ONLY "PM02".sensors_measurements
    ADD CONSTRAINT sensors_measurements_sensors_fk FOREIGN KEY (sensor_id) REFERENCES "PM02".sensors(sensor_id);
 ^   ALTER TABLE ONLY "PM02".sensors_measurements DROP CONSTRAINT sensors_measurements_sensors_fk;
       PM02          postgres    false    4765    247    250            A   �  x���K�#GD�U��0�&uo�W�?���{�5@�Iz
��`�Dg:O��B[}���<uoU��xq�Y!���.��'b)��!�s�!���Ү0h��dS���v9�A��/�y�0�}�D�A0d>��xvYu�}1��B~���؊T1N�ކܫ(´ꠃz_c��,~�3����ᚿ�h��^/���C"�~kk��b5�����:���T/��"�����"*�ɐ�n�.G x�� �h�}m��ق\܌�k��Nd..�dI�������bPD���D������g��2���_K><-��G�Ex��>yH��<g�-Rga�WlW
64W��>!-��r��Uk5��6P�`�z"�����&��E��r>JG޻7��C��6hM�t��w�aŬ5'�5�zU/F�^=��Q��bu�,����d�n�cm����ZQ�؇I'�V#�\zי��.�Y��[3Z&�gv�*�E/��-�󍲛�˛�-��'����L�5���Q$J�D9�8(��*j�QVP�IzP��I�F�`���S�c�`�GM����طy�Q頳��g?"/�ISN����q/�5qlx&��=��g�Z�V��JC�׽R{��L2����mz��)%}���m���|l���܃B�e�ʱ��EwH�1���dӱ���,���tD��m��ˊr%|��ga�,�B�Ao��a���̓���1@z��;�4י`�P�]'zYl*�}Be.�Y_��m<,���D�C�����ǉc�M��@�[���Śa���X�Y���ߞ��)mhBJ�0�$Ia9��=g�y�ڳ1G)ێ���nj��_-�����ߦ�n`�k.��2���9~xM�@����?���*o���;,)�2Nۅn�V�%��3�����,��ǃ�T5ohN����
i'���޺�ZDm���:�Hϱч������%�<��������-c�|e�К�Y���Ӂm�Aގ�g�JJ�|����_����x      >   <   x�3�(J-..-J�HTP�2�I�-H-J,	9+ ��9=Js3S2K*9��s��b���� ���      :      x��ZMo㺒]3��˙����L�v��v:� ���[�,��w���T���A�7�	�H��ԩ���*�t���Ϧ��X�bu]����J�{��cI�]+H��%�x����n+Œ�zŒL<��7�!��k-����[���vg�Y)�	$
�[�u��b}��F���i|����c��J����Ǟw&�E��] JV����$��"��S~���S=� M�3^��@��4u�3����DR��X��8k�}�%l�ήo�_��e*n���n�^$%�
o/�xu���œ�v�ay�r�W�A>=�se)n?`t�Ik��|I��W����yu+���[&��ݸk����)\H���`]S%^��U8�Wf�x�[g�^/_;!:6*�������i�La������a�u�xҦ�dLz���A����5�'�*��e�x��`SwV�4�8ĲJܴ��B�ĉ��D�G���h����j����Aƽ�~ ��w��R�΍{���26s��
�_�=m�z8�=��|0�����;��1ߥ��H{�;*<E+\!�a�x�$G ���GmT"/�Y�!8��o�մqe��n�� ��?�~0����2��_ �Z3\�-�ǖ�g�Z�3����89�R��-�Ur��K��x���M���^I�]7����:�UA9�HJ�d���t[;=&��bݴu�i�>��2b\<�F�ӂ�&�4?l?0JI�+/���ܵ�c�)�C��K���ZaW�b���iG�؜ݐ$R�:�О#��t��]����3����9/�ma���H��IyG'2�\�m��s$�y���ݭ_��q?h n�7T���w��Oz�`����d���0��9GB����t���>�
v\<��R��cw�\_����n��pK�f5�	�����Z_�>��E����Wp[�mK�ӕ���vko5	�I'���z :z}����"���o@
�tk:�.��\c�8{�q��^9p��=�@>����L.Ɍ�9hGVY�ͅD�����,�J����,�
� �� ��PHqWSHAw`�v\*h��l�r2�<hĆ�R�ݩnw�A�"�f��(�(�%�ڜ�o��}1,}4Uд��E�.x�e���4��KVR��Ww�5����&Q�_(l�o����@��9*$WR�$��9}��,���w欌d�ɤ@(�[��qV�DV3Al�w�Vx��c$�_�C�����m�ۙAx��5Rf}Ɍ(S,+�+ �,�|Н9�r~6
�zl��,"����L��&�!ʹJ�ou�a��2Xc����6�0Q:[V�Nĺc�DZP���2�
9��(89"*���S���1�#*���H��,����4Y�󭩚r-F�ٵ
'S,Jda�P�9Ky5�����[;O���{SP?�/�s���!(�k��q����~'��?���0�{�8f������&ꕂ�� ioj�r2d)Qr8�~���$�K�>�l�ˏg�8	~cy����^�V�{r��s˟Cf��K61*-�����ӥ��T����<�%|z�b��}�`/\�R���]XJ~K��"w�H�v�?E~^���[`�S�4���p��/�)�S�$�D H������	<r~Z�S (.n�����v��R/Cݦ���51XŦK�* ���6��A�:���چ(�U���As��{4�4>Ms�ڶ���V�d)�!�A
�x^���Ro������9|�,?�fҿ9+�yWJ����v�߬�}q6�Ko��b�
�����j�D�{
�*�7�����	�o�4�V��Lܛ��K���e��.gE�̶���j�J)'v�ׄX {��œ����tA^P9ל�h�Z4.(�ϦߠZ�ῖzՊ�l � � ����������\%Ai�u	&����d��f�SSƔ`57dQ%XB���d7x���f���d�P��-_N~�!�L��2/}k�`��y���˱�7���!���VG<
�Q%Hjt��7W�M�*�p��LY�XYp�Ww��k���]����|i�{�7��W(�<e�@��� -U�%�V{`
�!ai�����Wk�k�=���D6�0)fҤ<����(1,�`��"捁M��2J��{0P���2j␔`Hu�AH�F;#n�G�����y�����!}?F�B"�ud�x��|�<h����GI%���E氮}�6���Q#�0M��z*j`�2�l�2Ľֻ��=?�<'-���c[�X�BG���mV�
s�;�l`��v˧���9� �8��=��+t�Y%oS�{�x9s�-_��J.��⥉e�d�E�uh�< S6�e|7P��#���6n�7P���p����|1�S~ґ�=���f�H�ƺ�2�*�e3��`T��&�u '�]<�JdQ�����uS�ހ]��y�c̧X-r���Gd8b��Fp�'
��z��e?���H�fW-y�u���t�C
Gg<�哶�M��	q�hචB|�����mKA躋<l�:HwQ�ANVQ�;{�4�/�Z�u<#Z>��ä����'��X��^��k�Y����\w~ @�C_EU���#��v�����dR�l��<*�WJϑȯd1�m�,�4iQM�'^��sݠm3�qbN���wtw�%3AF3���M펨�4HLY^�\E���� ���al6{���������ש���n#�ji:������}�Y�_Cs�s P�z�N�x��¦�i���[�
�3�Ї��UY2�$�d�G��N�����_�o���ҹ�����qQ&n܇9�h�Omx�I)�Ǯӎg�̧}Ѐ�^�����q��D�5́ϩ�0'gI
˴�p\?a���4w�У���H��moZr���Ĺ�	��~HR�a��I�3�+�c���{;� f��ٴ:�[���u�Ñ$g	�L��oB.e0 ��4�FS�%�W�-P� z��������J���64|b6��r\5!��A��\@� ?l	(�j���HnR^O3�5J��t�4<	��1"���8P<�a�9d@O�xLC�ϧ"���v;�wqx��F�)��A?���oT�7Ȃ�����FPz�P�.X�%�޴���Q���$M�$�&~X�ە�$AtAr��"
���8�<�_/�a�mO�p�G�d��h�Հp�ۭ��N!Np�v�2/@�<n�_M��Y����|�7-:��>��X������b�ͷ���b���Z���r�}03�L��;� �s�-g��LW��
rI�t��R��R4�)1G^~������O��~�m��}l�'�>إ?������ܔ�s���/۞�4Q����e�؇�"���AZ�?�
�\�2�%
��T���vy����Kj"��N�[�$���ǐ$����)�H�K�e2(��@��H6N�y� �q�m-��!�=����J���|�[iI
ZK��O�4������D�\��i�춿,%�0L�c�~($�ÿ8�q6���$��)����Mi�M<"A*t�|
˽>�fA�$"��v����,6��`E�	$�M�_<����^�#˖ĥ��k��-�m��*�E���q���=�ǳk6�XGW�F�?�ǞH��-��f������↧�:������[P���v7"箵[F=�r:M�>�=qU�f�Mo�ܺ��<��
�7��S����-J�mSmL�X��xNͷC�C�y7m�j:���74��ԯ�!S�7Ӄf�2�,6b��|�%��/g��C���=��~�$�j�2���W6	�[�"Y<ջ� ���|z��ނ&[�
k�B���<WTIz����X߀�;ƙ���$4O7z;:�}��`��ڏS�1)K*�n��m��%<9̄��ǂ ���0��?����h���Rj����%٣�0p�\M9��$X���o@E�<E����l��#�5�8��Ŋήߏ4z����%5�a�w�h�!���������"���
�����3���m��:�:n:�|���bEN��-�/
�1�e����_�Y+O������ �  ��
����~D��X���??U�gZ�?�Q�9��Y?���?<���8M�GPi��ݣ�ʜ���b�6�B���]TΣ�J�7H@t52衶��*+��̆��$����S��2����⨜O͑�D��$>�C)T�5/�(�m��?O�y!nh$N��J%	}�ᓘ���i���/���z��#�Q��66�T^\�&!�XD��y��>���U��˙-S1I�~~����v�D��sLykHv6�٠26|�@�ߜ���ٿ����,o�7��ɽR�ʖ>m3�wKs�^�=�I����)��Wŏ�� 7��̓+(�r�Ls'r��ܸ�y���YL��ٜ���-$��n�q]�=�������"h_��5j�Qh�<��7۳��O�qʃ݌e0+���͙\�SD"vg�~�Ž��Y�+5�}���r� +UW�w�*+�?��{u�N?�O��De�\}���**���J�~�V �2�Wy5���V�BnfWŧ��\B]�TW�'�BWY�/Բ䪚]��A	�f�E~�N�$<I�)�̍P�kO�fu]��DN��S8:%ܨ�b�?»B$+�$���eʓ���ߘTb?'y6��m3{F�)L������~*�&��*�ݯ Sl^A3��^�C�~{����O�&o�O�5���\%t+���r�d��D��|�<E�0�����GV��J�i�" e{��b������sN;��|&@\�z*�T]�������,�Y�      @   �  x��W[�\)�N�b6����^Ĭ�@���0Gy+�u�55ю
��p*A�	9U��i���rZ�5f*{���V%0e~d���HS����yt�J����o�ԍs�j9���)�$n·�ޔ�5���?��I�T�i�%I�̘�'q5�!�͵��9kª���'i�%ٴ�����7�W��s��SDW��8g�-ͼ4�������(?����V#K�Ԗ�ԅs�@��43���g���;�f�F�c��I��0�L������gn�J�/���?�܍���lJ�4ZI�Gެ���`V{� z^5�F�ať���6F ����[
�)j� q�r��P�E�kr)-@$�(3�V9��Eq�\/s��o#r�uO����K�~�'�*���~s���</B��P��v2�Bt� 8�I�>�l�6@T/z��G����OM��9ے1�u�^��؅ȅc�7�`D�v沙�z ���H�Z�|�T_#��;"�Jw�*���aTp7�%/nsc].D@
�Ƿ<�\q_�@���t]X�~�G{�q?B=�,wO^BBk�4�ȴۜ��؁3�KN�>"��y�Q�ސ�͎o��XE�Hh�k9F��BK�[���'$m1&���$�/j�����:�f�X#N)��|p@9K������$ "w�Pq-m�a��������M��5�a{�1\�.�n��tM�5F�f�&�Q���0�㑅�]�u�?��UhOy��"��^�B;���Y��b���5⾋�}��n8��G��bD�j��o�������Ɣf���V��ǆL�BzA%��7����&9>\q
|	NEi���3�H��e�N�#�{��S���%��s�Ty���|��@v�.��N6���H��*#m�&ꖺ&����6���N,L:d�'X�畚�=�k��}*$���WMD*��P�|t_k#�Q�G��nX]m�Je�ywļX�8�1�#��F�
���OYXa3��4��6��87<��H6�"2��E
�y�%�x���u��<'��������dH��f��� B�ie���`6i�v�A,~w�1@NM"P'�����л�4���F|�&��BP��VZ�1B�,JT^HY6�1��;N�8Ūy�P�]A�q�i[�}�\ֳ(Hy��qHV�ċ����p�L\a�:���RH�9��\�� ��@ ��d���h���B$��=�� 8�g�4ڞLD@�3�h���YT}�Pd�]d~��bҐ�pP����)1��j�7]2���{���̒�^l��eё�6��A��Fꭰ8z�S��H��:�÷K���Rj�,�#rP(�*q��:"@���$�z��h��?�n�Ι!�
�9~�u�ـHG=]����}��;��φr�����g����`d~ue
�z5�o7�(�~A�/[8���l�(��HώsW**e� �S;[��� ���_�<����|ۭ�G��B5t�4�:�������y�0"�M��y�?jV�� ���oX�"�:����)��*~���Z(��Nf}16�z�I�;:N�W�S��«��������ɞZ9KHy�R"ۗ��v�+�M�	{<V��t��#
Q����#��N��)p��8rtg�6V���1�J�v�/�"G�#��8�ru��nP�ϛ�ޑ�-��C�~	���q9���@�Z����v�O;��?r}�3�R=�r�kE9`	���l�'�b�u�0�/A���+� @d�I������<�њ�g&����"EJ��VA�"��H(�!���/��T�g��b�>Ya��`J�i�� �m'V_���(�Q�>-?��?�\��V��^�~�����}놑�����	��%R�Ytr������]�7�4N�����)?���߿~��/ Z��      <   1   x�3�I-��/NN��2��H��,	J��+�2�(J-.�,����� 9X      ?      x������ � �     