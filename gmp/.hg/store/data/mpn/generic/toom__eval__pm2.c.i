        �  S      2R��������X��jp�{���9�� Og�            x��V�o�F~>�ӋTA���{iI*��K`�1��S��Y�{my��q�����c���Q�wg��f��qZ��b��(��g7��a0p����qlDr7 .��W,���4 �FB%|�*� ��<XS����)�o��,�0�7X��8}zS��#L��	�́�4-ǰ-} ����SG���h��w�&����<�D����6�n�Μ�=�>��~ԝ���{O��\:�GG������%:8}ݡ�Gs0�n_��poN����m�1gjY��1��hjZ7�7	_�
�WW�A/a&�R��	�^����x$������%�3v�rWI�y�&���x�\��/s�l�<W@�\����k�(�0Z��F����,�bI(���x��K���tpczLH�Ҥ�c�����%���<�g�H|��"N�V$Uq�N�(&�*��@������~���I�~cN>bb�/<`� �l�u@K��5�:�[O�����Z*?J�g���ap�ŔW�16�UiL�IC�=ӱ�	j��X��;�H�S{<��d'��][���2k�p����y?aC%2���1���\�Pi���Xei�&/�K���D��R�����Ks%�f��Z�F�����i�^�.|^�q��\�hP�hWk]�Ɖ,���`+�����z��8�B���iR@��NgU%�g�J�[ܮC�q�
�W˴����^p<���5�l%��f
��/v0*�j?p2�xߐ���0�'�v�����K���L��)o�ށ��aUHѻ�Q�n �3T�����A����f�%�8��`�"Y�[��T��u�̜(�p� �´��K��������1�t����],���cA�������ՙꗁ�/1 ���<I��._:�������)�-kg �9&�1��N*��@�TPQY�����f{zr�pr���X�������x���`�	�J��(��pl�L�kϦd��ѱ�]C#[y���'��%{/�a�ދ�fo�.( ��s2 �)�e�t��rJ���H(�9��	d��O�*ؖ4V�e���cQ��D~%����?a��?Ñ��� (�<����e����t'�L�?��pX"�
�xa��f��u�IS��8���L��D����Pq\p��ml^K�5�o��!����c��]�j�G��'�E絼#�V/�|��r������Zm\�>W���En�&$�����-���4ۯ�O�?��u    �     @  �      2T    ����@"����q����[*-���              ;  ;   4#if HAVE_NATIVE_mpn_addlsh_n
  mp_limb_t cy;
#endif
    =     <  �     2U   ����-թ�8�������j��+�                 P   0    mpn_add_n_sub_n (xp2, xm2, xp2, tp, n + 1);
    y     C  �     2�   ���������2M!DH|g�O              �  �   7mpn_toom_eval_pm2 (mp_ptr xp2, mp_ptr xm2, unsigned k,
    �     =  �     2�   ����7
�=���.��,��#d��e              
�  
�   1  neg = (mpn_cmp (xp2, tp, n + 1) < 0) ? ~0 : 0;
    �    ;  j     2�   �����V����3֌Q����<�z            x��SMn�@��(#v��WETvb'��
ە"Q��H4*J�$���q�8j+.��+pv� .�x�&��<����}�1c5��������yS�8�_�'��������Ed%o�A(d�g/����&7z��)�5�s��rp]�s'��p�z�Gw�W�Hh=�7�d������;��[�u[D�4I�+!��4��@�Q��r��D��j�Rc���$S�I:�Z���y��xI۬�>�:�V���K"�����yRR��/����٣��k B��J>�x]\��)�,�)�GZ���ӣWh1=��a��;}�	�z�[ �zf���Mu������q��
kT٩E{��N�����r2*��&c��0��ԡj�b�?q ��z��x��~���iW'��h�F�%��M>����4� 6M��md�?[���o�K�j�b�f�z�g_IoS���W��W�e�ʏ���1����7�O�F�#��ī�RZ�B�\W�۶��V��qY!Jȁ����u�[��U7�
d0ŅG��ԑe�OE�]�\J��� �WJ{    4     �  �     2�   �����3��R����J;8�s�:�?�            x�����PF�����7�i���AI���ܤ�ڨ�F/�}�NbvS��p��|��r'�<�hk�19���$/��g�Ud����"�|w�6��+��e��N��V��D@�\�+�@�!�vmS#���P���[A��ʬ=���2���qw1y�F?�"H�8�$t��@9X�V�
��%���x1D�    �     �  c     2�   �����`"��BJܰ��'��r{�6�            x�]��j1D�Hu_1�}VbR����T�B{+_��F����ȷ���;���#�%��VS�}7��Q��?���+HE7�؇Xp��1dp�8pŋ��U�;�}�[�^?��X�O��u.9��\m�@Fw�.M������s��m�NK��6�%��Ÿ������Ӈ�OjT"�e�\{M��V���u�)~H9    	�     1  h     4�   �����Re���ތ ��y�ݼ3              n  �   %#if 0 && HAVE_NATIVE_mpn_add_n_sub_n
    	�     ,  c     4�   �����8�xr�)�e]3c�{��O              n  �    #if HAVE_NATIVE_mpn_add_n_sub_n
    
     ?  d   	  5}   	�������g��E��n�Rqx,N��            x�c``�```����`����Y��Y���_T��d�)�(��*$�($��`ɼ|�D�����> F2�    
V     [  e   
  >�   
�����G�[�to���iX����              �  L   Oalong with the GNU MP Library.  If not, see https://www.gnu.org/licenses/.  */
    
�     Q  f     >�   ��������An"2��TG&�Ws�               <   �   E   Contributed to the GNU project by Niels Möller and Marco Bodrato
         �  f     ?m   ����@��8S奧�C}�Em1            x�E��
�@D���'�TK{�	��I6� ކ���߲�߼����f��Q�&����|+����=@�������B���zpJ׈�$�����Zg�U��dK�i��S���b!1�����j�r�g�:.��g��!� !@c    �    i  \     ?�   ������ 7q��W�J����E�k�            x���MN�0����\�-U�;XU��J�DM�@��f�X2vd;�z��ݘ�!U�����y��B���#j[�G,	��}�[�4_����qW��0���,ye��s���@PU�J*0�tSO�@Q�_����=7��|�;N[�v�]��q�"6�������#(��Q�k6��������$쌶P�l��N�	�����ڢR�g��Z&v�D
���yB�q�`8_�97���'���lԟ �M���2�\�|��r�J���/(*mBg�$���m�o]�P��(՚�iAz��,\�)|,�-Q[�-�?�8�B�y~j^g\�{�7��p	�bO^���
gi�4M��u��*5o:!���T�.�@           K     B�   �����0�>ŵ�Q`�M�l���x���              E  V    