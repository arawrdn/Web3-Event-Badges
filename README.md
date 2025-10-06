# Web3EventBadges

NFT-based attendance and participation system for Web3 events. Users can check in and automatically receive unique badges on-chain, with timestamp recording and efficient contract logic.

## Features
- Automatic NFT badge minting upon user check-in
- On-chain attendance and participation tracking
- Hardhat scripts for deployment and testing
- Ready-to-use Solidity contracts for event organizers

---

## Setup, Compile, Test & Deploy

```bash
# 1. Clone the repository
git clone https://github.com/your-username/Web3EventBadges
cd Web3EventBadges

# 2. Install dependencies
npm install
# or
yarn install

# 3. Install Hardhat locally (if not installed)
npm install --save-dev hardhat

# 4. Verify Hardhat installation
npx hardhat --version

# 5. Compile all Solidity contracts (version 0.8.30)
npx hardhat compile

# 6. Run unit tests
npx hardhat test

# 7. Deploy contracts
#   - Update scripts/deploy.js with your base URI if needed
#   - The deployer wallet is set to: 0x2A6b5204B83C7619c90c4EB6b5365AA0b7d912F7
#   - Deploy to local network:
npx hardhat run scripts/deploy.js

#   - Deploy to testnet (e.g., Base, Goerli):
npx hardhat run scripts/deploy.js --network base

# 8. Verify deployment and interact with contract
#   - Open Hardhat console:
npx hardhat console --network base

#   - Example usage in console:
const badge = await ethers.getContractAt("CheckInBadge","0x2EeA914f66985F7cC31A893591cf05ca543Dc50d")
await badge.checkIn()
await badge.hasAttended("0x2A6b5204B83C7619c90c4EB6b5365AA0b7d912F7")
