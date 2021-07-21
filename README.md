# Crystal OpenFaaS Template

Inofficial OpenFaaS template for the crystal programming language
(currently 1.1.0 🎉).

To find out more about the OpenFaaS templates see the [faas templates](https://github.com/openfaas/templates) and [faas-cli](https://github.com/openfaas/faas-cli).

## Usage

Go to your openFaaS project and execute:
```
faas-cli template pull https://github.com/TPei/crystal_faas_template
```

Alternatively, the template is also available via the OpenFaaS template store
```
faas-cli template store pull crystal
```

This will pull the template into your directory and allow you to use
```
faas-cli new --lang crystal my_function
```
to create a new crystal function

See [crystal_faas_whalesay_demo](https://github.com/TPei/crystal_faas_whalesay_demo) for an implementation example.

### Development

#### General

As with all OpenFaaS templates, this template creates a `my_function/handler.cr` file, as well as a `my_function.yml`. In addition to this, a `my_function/shard.yml` is created for your dependencies.

When building your function with `faas-cli build -f my_function.yml` your dependencies will be resolved according to your shard file.

#### Code
`Hander#run` gets passed a `req` String, if you want to handle json, simply do `JSON.parse(req)` and do your thing :)

Your function always needs to return JSON, like so: `return JSON::Any.new("Just a String, but JSON!")`

```crystal
require "json"

class Handler
  def run(req : String)
    whale = <<-WHALE
     #{"-" * req.size}
    < #{req} >
     #{"-" * req.size}
           \\
            \\
             \\
              \\       ##               .
               \\## ## ##             ==
              ## ## ## ## ##         ===
           /"""""""""""""""""\\___/ ====
    ~~~ ~~{~ ~~~  ~~~~~ ~~~~~ ~~~/~~====-~ ~~~~
           \\______ O           __/
            \\    \\         __/
             \\____\\_______/
    WHALE
    return JSON::Any.new(whale)
  end
end
```

## Templates Developers / Contributors

See [contributing
guide](https://github.com/openfaas/templates/blob/master/CONTRIBUTING.md).

## License

This project is licensed under the MIT License.
