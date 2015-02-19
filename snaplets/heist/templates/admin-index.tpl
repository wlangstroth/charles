<apply template="admin">
  <div>
    <table>
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
          <dfInputText ref="description"/>
        </td>
        <td>
          <dfInputText ref="price"/>
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
