import yaml

def read_yaml(file_path):
    with open(file_path, 'r') as file:
        data = yaml.safe_load(file)
    return data

def write(data):
    shebang = '#!/bin/bash\n\n'
    for k,v in data['.snippets'].items():
        filename = f'./scripts/generated/{k}.sh'
        print(f'Writing to {filename}')
        with open(filename, 'w') as f:
            f.write(shebang + v[0])

# Main function
def main():
    file_path = '.gitlab/ci/snippets.yml' # Replace with the path to your YAML file
    data = read_yaml(file_path)
    write(data)
    # Create gist
    # gh gist create --public --desc "List of snippet to install common cli tools. Helpful for CI" scripts/generated/*.sh


if __name__ == '__main__':
    main()
