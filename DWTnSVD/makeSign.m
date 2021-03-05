%ImageSize�Ŏw�肵���T�C�Y�̉摜��Sign�𖄂ߍ��߂�悤��Sign���g������B����Sign�͎w�肵���̏ꏊ�ɓ���
%�T�C�Y������Ȃ������Ƃ��ǂ��Ȃ邩�͒m��Ȃ�
function [result] = makeSign(ImageSize,Sign,Place)

%�u���b�N�̌��i�s�A��j
BlockNumber = fix( (ImageSize / 2) ./ size(Sign) );

TmpSign = padarray(sign(Sign), (Place - [1,1]) .* size(Sign),1,'pre'); 

Sign = padarray(TmpSign, (BlockNumber - Place) .* size(Sign), 1, 'post'); 
%imshow(Sign * 255);

result = Sign;