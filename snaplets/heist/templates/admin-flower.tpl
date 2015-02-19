<apply template="admin">
  <h1>Edit Plant</h1>
  <div class="admin-form">
    <dfChildErrorList/>
    <dfForm action="/admin/flowers">
      <dfLabel ref="title">Latin Name: </dfLabel>
      <dfInputText ref="latin"/>
      <br>
      <dfLabel ref="common">Common Name(s): </dfLabel>
      <dfInputText ref="common"/>
      <br>
      <dfLabel ref="description">Description: </dfLabel>
      <dfInputText ref="description"/>
      <br>
      <dfLabel ref="price">Price: </dfLabel>
      <dfInputText ref="price"/>
      <br>
      <dfLabel ref="bloom">Blooms: </dfLabel>
      <dfInputText ref="bloom"/>
      <br>
      <dfInputSubmit/>
    </dfForm>
  </div>
</apply>
