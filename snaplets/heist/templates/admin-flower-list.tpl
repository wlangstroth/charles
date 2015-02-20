<apply template="admin">
  <h1>Flowers</h1>
  <div>
    <table class="table">
      <thead>
      <tr>
        <th>Latin</th>
        <th>Common Name(s)</th>
        <th>Description</th>
        <th>Price</th>
        <th>Bloom</th>
      </tr>
      </thead>
      <dfForm action="/admin/flowers">
      <dfChildErrorlist/>
      <tr>
        <td>
          <dfInputText ref="latin"/>
        </td>
        <td>
          <dfInputText ref="common"/>
        </td>
        <td>
          <dfInputText ref="description" style="width: 25em"/>
        </td>
        <td>
          <dfInputText ref="price" style="width: 17em"/>
        </td>
        <td>
          <dfInputText ref="bloom"/>
        </td>
        <td>
          <dfInputSubmit/>
        </td>
      </tr>
      </dfForm>
      <flowers/>
    </table>
  </div>
</apply>
