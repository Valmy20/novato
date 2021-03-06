jQuery ->
  new AvatarCropper()

class AvatarCropper
  constructor: ->
    $('#user_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_crop_x').val(coords.x)
    $('#user_crop_y').val(coords.y)
    $('#user_crop_w').val(coords.w)
    $('#user_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
  	$('#user_preview').css
  		width: Math.round(100/coords.w * $('#user_cropbox').width()) + 'px'
  		height: Math.round(100/coords.h * $('#user_cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
  		marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'

jQuery ->
  new CoverCropper()

class CoverCropper
  constructor: ->
    $('#cover_user_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 600, 600]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_cropc_x').val(coords.x)
    $('#user_cropc_y').val(coords.y)
    $('#user_cropc_w').val(coords.w)
    $('#user_cropc_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
  	$('#cover_user_preview').css
  		width: Math.round(100/coords.w * $('#cover_user_cropbox').width()) + 'px'
  		height: Math.round(100/coords.h * $('#cover_user_cropbox').height()) + 'px'
  		marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
  		marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
