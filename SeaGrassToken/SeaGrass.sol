//SPDX-License-Identifier: MIT

pragma solidity 0.8.18;

contract SeaGrass {
    event Approval(address indexed owner, address indexed spender, uint256 amount);
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);

    address private _dugongTreasury;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;

    mapping(address => uint256) private _balance;
    mapping(address => mapping(address => uint256)) private _allowance;

    constructor() {
        _dugongTreasury = address(0x80840bcEBf90C958E9b34D913b62713B18B994AE);
        _name = "SeaGrass Token";
        _symbol = "SEAGRASS";
        _decimals = 18;
        _totalSupply = 1500000 * (10 ** _decimals);
        
        _balance[_dugongTreasury] = _totalSupply;
        emit Transfer(address(this), _dugongTreasury, _totalSupply);
    }

    function name() external view returns(string memory) {
        return _name;
    }

    function symbol() external view returns(string memory) {
        return _symbol;
    }

    function decimals() external view returns(uint8) {
        return _decimals;
    }

    function totalSupply() external view returns(uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) external view returns(uint256) {
        return _balance[owner];
    }

    function allowance(address owner, address spender) external view returns(uint256) {
        return _allowance[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns(bool) {
        _allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transfer(address recipient, uint256 amount) external returns(bool) {
        require(_balance[msg.sender] > 0, "Zero Balance.");
        require(_balance[msg.sender] >= amount, "Low Balance.");
        _balance[msg.sender] -= amount;
        _balance[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns(bool) {
        require(_allowance[sender][msg.sender] > 0, "Zero Allowance.");
        require(_allowance[sender][msg.sender] >= amount, "Low Allowance.");
        require(_balance[sender] > 0, "Zero Balance.");
        require(_balance[sender] >= amount, "Low Balance.");
        _allowance[sender][msg.sender] -= amount;
        _balance[sender] -= amount;
        _balance[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}
