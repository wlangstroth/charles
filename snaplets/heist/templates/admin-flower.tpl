<apply template="admin">
  <h1 class="page-header">Edit Plant</h1>
  <div class="admin-form">
    <dfChildErrorList/>
    <dfForm action="/admin/flowers" class="form-horizontal">
    <div class="form-group">
      <dfLabel ref="title" class="col-sm-2 control-label">Latin Name</dfLabel>
      <div class="col-sm-10">
        <dfInputText ref="latin" class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <dfLabel ref="common" class="col-sm-2 control-label">Common Name(s)</dfLabel>
      <div class="col-sm-10">
        <dfInputText ref="common" class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <dfLabel ref="description" class="col-sm-2 control-label">Description</dfLabel>
      <div class="col-sm-10">
        <dfInputText ref="description" class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <dfLabel ref="price" class="col-sm-2 control-label">Price</dfLabel>
      <div class="col-sm-10">
        <dfInputText ref="price" class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <dfLabel ref="bloom" class="col-sm-2 control-label">Blooms</dfLabel>
      <div class="col-sm-10">
        <dfInputText ref="bloom" class="form-control"/>
      </div>
    </div>
    <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
        <dfInputSubmit class="btn btn-primary"/>
      </div>
    </div>
    </dfForm>
  </div>
</apply>
